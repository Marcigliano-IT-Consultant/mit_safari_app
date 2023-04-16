import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:mit_safari_app/helper/timer.dart';
import 'package:stream_transform/stream_transform.dart';

part 'map_event.dart';
part 'map_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc({required Timer timer})
      : _timer = timer,
        super(MapState()) {
    on<GetMapPosition>(
      _determinePosition,
      transformer: throttleDroppable(throttleDuration),
    );
    on<StartTracking>(
      _onStarted,
      transformer: throttleDroppable(throttleDuration),
    );
    on<PauseTracking>(
      _onPaused,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ResumeTracking>(
      _onResumed,
      transformer: throttleDroppable(throttleDuration),
    );
    on<StopTracking>(
      _onStopped,
      transformer: throttleDroppable(throttleDuration),
    );
    on<TrackingTicked>(
      _onTicked,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final Timer _timer;
  StreamSubscription<int>? _timerSubscription;

  void _onStarted(
    StartTracking event,
    Emitter<MapState> emit,
  ) {
    emit(TimerRunInProgress());
    _timerSubscription?.cancel();
    _timerSubscription = _timer
        .tick(duration: const Duration(seconds: 1))
        .listen((duration) => add(TrackingTicked(duration: duration)));
  }

  void _onPaused(
    PauseTracking event,
    Emitter<MapState> emit,
  ) {
    _timerSubscription?.pause();
    emit(state.copyWith(tracking: TrackingMode.paused));
  }

  void _onResumed(
    ResumeTracking event,
    Emitter<MapState> emit,
  ) {
    _timerSubscription?.resume();
    emit(state.copyWith(tracking: TrackingMode.tracking));
  }

  void _onStopped(
    StopTracking event,
    Emitter<MapState> emit,
  ) {
    _timerSubscription?.cancel();
    emit(state.copyWith(tracking: TrackingMode.stopped));
  }

  Future<void> _onTicked(
    TrackingTicked event,
    Emitter<MapState> emit,
  ) async {
    if (event.duration % 5 == 0) {
      final position = await Geolocator.getCurrentPosition();
      emit(
        state.copyWith(
          location: LatLng(position.latitude, position.longitude),
        ),
      );
    }
    emit(state.copyWith(duration: event.duration));
  }

  Future<void> _determinePosition(
    GetMapPosition event,
    Emitter<MapState> emit,
  ) async {
    bool serviceEnabled;
    LocationPermission permission;
    try {
      await _timerSubscription?.cancel();
      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        emit(state.copyWith(status: MapStatus.disabled));
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(state.copyWith(status: MapStatus.denied));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        emit(state.copyWith(status: MapStatus.deniedForever));
        return;
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      final position = await Geolocator.getCurrentPosition();
      emit(
        state.copyWith(
          status: MapStatus.ready,
          location: LatLng(position.latitude, position.longitude),
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: MapStatus.error));
    }
  }
}
