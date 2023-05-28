import 'package:latlong2/latlong.dart';
import 'package:map_tracking_repository/authentication_repository.dart';
import 'package:realm/realm.dart';
import 'package:test/test.dart';

void main() {
  final mapTracking =
      MapTrackingRepository('mongodb://localhost:27017/mit_mongo_db_test');

  setUp(() async {
    await mapTracking.connect();
  });
  // Log current user out
  tearDown(() async {
    await mapTracking.close();
  });
  test('Add Entry', () async {
    final save = TrackingPoint.fromMap({
      'uuid': '545fabd8-fd44-11ed-be56-0242ac120002',
      'location': LatLng(-1.94995, 30.05885).toJson(),
      'timestamp': DateTime.now().toString(),
      'speed': 0.1
    });

    final result = await mapTracking.writeTrackingEntry(save);
    expect(result.speed, 0.1);
    expect(result.location.latitude, -1.94995);
  });

  test('Get Tracking Route', () async {
    final result = await mapTracking.getTrackingRoutes(
      {'uuid': '545fabd8-fd44-11ed-be56-0242ac120002'},
    );
    expect(
      result.first.uuid.toString(),
      '545fabd8-fd44-11ed-be56-0242ac120002',
    );
  });

  test('Get Tracking empty Route', () async {
    final result = await mapTracking.getTrackingRoutes(
      {'uuid': '545fabd8-fd44-11ed-be56-0242ac120003'},
    );
    expect(result.length, 0);
  });
}
