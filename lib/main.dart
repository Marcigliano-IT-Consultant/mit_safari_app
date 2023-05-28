import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:map_tracking_repository/authentication_repository.dart';
import 'package:mit_safari_app/app.dart';
import 'package:mit_safari_app/simple_bloc_observer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:posts_repository/posts_repository.dart';
import 'package:weather_repository/weather_repository.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  runApp(
    App(
      weatherRepository: WeatherRepository(),
      postsRepository: PostsRepository(),
      mapTrackingRepository: MapTrackingRepository(dotenv.get('MONGO_DB_URL')),
    ),
  );
}
