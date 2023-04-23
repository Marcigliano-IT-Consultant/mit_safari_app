import 'package:flutter/material.dart';
import 'package:mit_safari_app/map/bloc/map_bloc.dart';
import 'package:mit_safari_app/map/view/map_widget.dart';

class MapSelector extends StatelessWidget {
  const MapSelector({super.key, required this.status});
  final MapStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case MapStatus.initial:
        return const Center(child: CircularProgressIndicator());
      case MapStatus.disabled:
        return const Center(
          child: Text('Location services are disabled.'),
        );
      case MapStatus.deniedForever:
        return const Center(
          child: Text(
            'Location permissions are permanently denied, we cannot request permissions.',
          ),
        );
      case MapStatus.denied:
        return const Center(
          child: Text(
            'Location permissions are denied',
          ),
        );
      case MapStatus.error:
        return const Center(
          child: Text('Error fetching the location'),
        );
      case MapStatus.tracking:
      case MapStatus.ready:
        return const MapView();
    }
  }
}
