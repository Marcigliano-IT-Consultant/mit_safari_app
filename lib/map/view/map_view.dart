import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_safari_app/helper/timer.dart';
import 'package:mit_safari_app/map/map.dart';
import 'package:mit_safari_app/map/view/map_selector.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapBloc(
        timer: const Timer(),
      )..add(GetMapPosition()),
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          
          return Scaffold(
            appBar: AppBar(title: const Text('Map')),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: MapSelector(status: state.status),
            ),
          );
        },
      ),
    );
  }
}
