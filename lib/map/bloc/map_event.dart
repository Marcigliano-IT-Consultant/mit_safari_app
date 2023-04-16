part of 'map_bloc.dart';

class MapEvent extends Equatable{
  const MapEvent();

  @override
  List<Object> get props => [];
}

class GetMapPosition extends MapEvent {}


class StartTracking extends MapEvent {
  const StartTracking();
}

class PauseTracking extends MapEvent {
  const PauseTracking();
}

class ResumeTracking extends MapEvent {
  const ResumeTracking();
}

class StopTracking extends MapEvent {
  const StopTracking();
}

class TrackingTicked extends MapEvent {
  const TrackingTicked({required this.duration});
  final int duration;

  @override
  List<Object> get props => [duration];
}
