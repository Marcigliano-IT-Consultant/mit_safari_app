import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:mit_safari_app/map/map.dart';
import 'package:mit_safari_app/map/view/map_action_buttons.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Expanded(
          child: FlutterMap(
            options: MapOptions(
              center: state.location,
              zoom: 17,
            ),
            nonRotatedChildren: [
              AttributionWidget.defaultWidget(
                source: 'OpenStreetMap contributors',
                onSourceTapped: null,
              ),
            ],
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: state.location,
                    builder: (context) => const Icon(
                      Icons.circle,
                      color: Colors.red,
                      size: 5,
                    ),
                  )
                ],
              ),
              MapActionButtons(
                status: state.tracking,
              ),
            ],
          ),
        );
      },
    );
  }
}
