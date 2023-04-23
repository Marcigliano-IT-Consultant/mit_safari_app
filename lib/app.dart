import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map_tracking_repository/authentication_repository.dart';
import 'package:mit_safari_app/home/home.dart';
import 'package:mit_safari_app/theme/theme.dart';
import 'package:posts_repository/posts_repository.dart';
import 'package:weather_repository/weather_repository.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required WeatherRepository weatherRepository,
    required PostsRepository postsRepository,
    required MapTrackingRepository mapTrackingRepository,
  })  : _weatherRepository = weatherRepository,
        _postsRepository = postsRepository,
        _mapTrackingRepository = mapTrackingRepository;

  final WeatherRepository _weatherRepository;
  final PostsRepository _postsRepository;
  final MapTrackingRepository _mapTrackingRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WeatherRepository>(
          create: (context) => _weatherRepository,
        ),
        RepositoryProvider<PostsRepository>(
          create: (context) => _postsRepository,
        ),
        RepositoryProvider<MapTrackingRepository>(
          create: (context) => _mapTrackingRepository,
        )
      ],
      child: BlocProvider(
        create: (_) => ThemeCubit(),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<ThemeCubit, Color>(
      builder: (context, color) {
        return MaterialApp(
          theme: ThemeData(
            primaryColor: color,
            textTheme: GoogleFonts.rajdhaniTextTheme(),
            appBarTheme: AppBarTheme(
              titleTextStyle: GoogleFonts.rajdhaniTextTheme(textTheme)
                  .apply(bodyColor: Colors.white)
                  .headline6,
            ),
          ),
          home: const HomePage(),
        );
      },
    );
  }
}
