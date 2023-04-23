class TrackingRoute {
  TrackingRoute(
      {required this.timestamp, required this.location, required this.speed,}
  );

  factory TrackingRoute.fromMap(Map<String, dynamic> map) {
    return TrackingRoute(
      timestamp: DateTime.parse(map['timestamp'] as String) ,
      location: map['location'] as String,
      speed: map['speed'] as double,
    );
  }

  final DateTime timestamp;
  final String location;
  final double speed;
}
