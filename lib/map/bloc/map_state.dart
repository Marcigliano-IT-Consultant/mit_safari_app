part of 'map_bloc.dart';

enum MapStatus {
  initial,
  disabled,
  denied,
  deniedForever,
  error,
  ready,
  tracking,
}

enum TrackingMode {
  stopped,
  paused,
  tracking,
}

extension MapStatusX on MapStatus {
  bool get isInitial => this == MapStatus.initial;
  bool get isLoading => this == MapStatus.initial;
  bool get isSuccess => this == MapStatus.ready;
}

class MapState extends Equatable {

  MapState({
    this.tracking = TrackingMode.stopped,
    int? duration,
    MapStatus? status,
    LatLng? location,
    double? speed,
  }) :
      duration = duration ?? 0,
      status = status ?? MapStatus.initial, 
      location = location ?? LatLng(0,0), 
      speed = speed ?? 0;

  final MapStatus status;
  final LatLng location;
  final double speed;
  final TrackingMode tracking;
  final int duration;

  MapState copyWith({
    int? duration,
    MapStatus? status,
    TrackingMode? tracking,
    LatLng? location,
    double? speed,
  }) {
    return MapState(
      duration: duration ?? this.duration,
      status: status ?? this.status,
      tracking: tracking ?? this.tracking,
      location: location ?? this.location,
      speed: speed ?? this.speed,
    );
  }

  @override
  List<Object?> get props => [status, tracking, location, duration];
}

class TimerStarted extends MapState {
  TimerStarted() : super();
  @override
  String toString() => 'TrackingStarted';
}

class TrackingInitial extends MapState {
  TrackingInitial();
  @override
  String toString() => 'TimerInitial';
}

class TimerRunPause extends MapState {
  TimerRunPause();

  @override
  String toString() => 'TimerRunPause';
}

class TimerRunInProgress extends MapState {
  TimerRunInProgress() : super(
    status: MapStatus.ready, 
    tracking: TrackingMode.tracking,
  );

  @override
  String toString() => 'TimerRunInProgress';
}

class TrackingRunCompleted extends MapState {
  TrackingRunCompleted(): super(
    status: MapStatus.ready, 
    tracking: TrackingMode.stopped,
  );
}
