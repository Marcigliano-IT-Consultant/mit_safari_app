import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_tracking_repository/authentication_repository.dart';
part 'route_event.dart';
part 'route_state.dart';


class RouteBloc extends Bloc<RouteState, RouteEvent> {
  RouteBloc(this._repository) : super(RouteState as RouteEvent);
  final MapTrackingRepository _repository;

  Future<List<TrackingPoint>> getTrackingRoutes() async {
    await _repository.connect();
    final list = await _repository.getTrackingRoutes({});
    await _repository.close();
    return list
        .map(
          (doc) => TrackingPoint.fromMap(doc as Map<String, dynamic>),
        )
        .toList();
  }
}
