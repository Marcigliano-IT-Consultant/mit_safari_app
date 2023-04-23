import 'package:map_tracking_repository/authentication_repository.dart';
import 'package:realm/realm.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MapTrackingRepository {
  final Db _db; //=  _db = Db('mongodb://localhost:27017/mit_mongo_db');

  MapTrackingRepository(String connectionString) : _db = Db(connectionString);

  Future<void> connect() async {
    await _db.open();
  }

  Future<List<TrackingRoute>> getTrackingRoutes() async {
    final collection = _db.collection('trackingRoutes');
    final query =
        where.exists('timestamp').fields(['timestamp', 'location', 'speed']);
    final cursor = collection.find(query);
    final list = await cursor.toList();
    return list.map(TrackingRoute.fromMap).toList();
  }

  Future<void> close() async {
    await _db.close();
  }
}
