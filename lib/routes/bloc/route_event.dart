part of 'route_bloc.dart';

class RouteEvent extends Equatable{
  const RouteEvent();

  @override
  List<Object> get props => [];
}

class GetRoutePosition extends RouteEvent {}


class StartTracking extends RouteEvent {
  const StartTracking();
}

class PauseTracking extends RouteEvent {
  const PauseTracking();
}

class ResumeTracking extends RouteEvent {
  const ResumeTracking();
}

class StopTracking extends RouteEvent {
  const StopTracking();
}

class TrackingTicked extends RouteEvent {
  const TrackingTicked({required this.duration});
  final int duration;

  @override
  List<Object> get props => [duration];
}
