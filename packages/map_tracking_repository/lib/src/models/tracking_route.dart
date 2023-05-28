import 'package:latlong2/latlong.dart';
import 'package:realm/realm.dart';

class TrackingPoint {
  TrackingPoint({
    required this.uuid,
    required this.timestamp,
    required this.location,
    required this.speed,
  });

  factory TrackingPoint.fromMap(Map<String, dynamic> map) {
    return TrackingPoint(
      uuid: Uuid.fromString(map['uuid'] as String),
      timestamp: DateTime.parse(map['timestamp'].toString()),
      location: LatLng.fromJson(map['location'] as Map<String, dynamic>),
      speed: map['speed'] as double,
    );
  }

  factory TrackingPoint.fromMongo(Map<String, Object?> map) {
    final timestamp = map['timestamp']!.toString();
    return TrackingPoint(
      uuid: Uuid.fromString(map['uuid']! as String),
      timestamp: DateTime.parse(timestamp),
      location: LatLng.fromJson(map['location']! as Map<String, dynamic>),
      speed: double.parse(map['speed']!.toString()),
    );
  }

  Map<String, dynamic> toMongo(TrackingPoint map) {
    return {
      'uuid': map.uuid.toString(),
      'location': map.location.toJson(),
      'timestamp': map.timestamp,
      'speed': map.speed,
    };
  }

  final Uuid uuid;
  final DateTime timestamp;
  final LatLng location;
  final double speed;
}
