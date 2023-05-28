import 'package:latlong2/latlong.dart';
import 'package:map_tracking_repository/authentication_repository.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MapTrackingRepository {
  //=  _db = Db('mongodb://localhost:27017/mit_mongo_db');

  MapTrackingRepository(String connectionString) : _db = Db(connectionString);
  final Db _db;

  Future<void> connect() async {
    await _db.open();
  }

  Future<TrackingPoint> writeTrackingEntry(TrackingPoint route) async {
    final collection = _db.collection('trackingRoutes');
    final result = await collection.insertOne(route.toMongo(route));
    final doc = TrackingPoint.fromMongo(result.document!);
    return doc;
  }

  Future<List<TrackingPoint>> getTrackingRoutes(
    Map<String, dynamic> search,
  ) async {
    final collection = _db.collection('trackingRoutes');
    final cursor = collection.find(search);
    final list = await cursor.toList();
    return list.map(TrackingPoint.fromMap).toList();
  }

  Future<void> close() async {
    await _db.close();
  }
}
