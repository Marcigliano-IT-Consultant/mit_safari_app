part of 'route_bloc.dart';

enum RouteStatus {
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

extension RouteStatusX on RouteStatus {
  bool get isInitial => this == RouteStatus.initial;
  bool get isLoading => this == RouteStatus.initial;
  bool get isSuccess => this == RouteStatus.ready;
}

class RouteState extends Equatable {

  RouteState({
    this.tracking = TrackingMode.stopped,
    int? duration,
    RouteStatus? status,
    LatLng? location,
    double? speed,
  }) :
      duration = duration ?? 0,
      status = status ?? RouteStatus.initial, 
      location = location ?? LatLng(0,0), 
      speed = speed ?? 0;

  final RouteStatus status;
  final LatLng location;
  final double speed;
  final TrackingMode tracking;
  final int duration;

  RouteState copyWith({
    int? duration,
    RouteStatus? status,
    TrackingMode? tracking,
    LatLng? location,
    double? speed,
  }) {
    return RouteState(
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

class TimerStarted extends RouteState {
  TimerStarted() : super();
  @override
  String toString() => 'TrackingStarted';
}

class TrackingInitial extends RouteState {
  TrackingInitial();
  @override
  String toString() => 'TimerInitial';
}

class TimerRunPause extends RouteState {
  TimerRunPause();

  @override
  String toString() => 'TimerRunPause';
}

class TimerRunInProgress extends RouteState {
  TimerRunInProgress() : super(
    status: RouteStatus.ready, 
    tracking: TrackingMode.tracking,
  );

  @override
  String toString() => 'TimerRunInProgress';
}

class TrackingRunCompleted extends RouteState {
  TrackingRunCompleted(): super(
    status: RouteStatus.ready, 
    tracking: TrackingMode.stopped,
  );
}
