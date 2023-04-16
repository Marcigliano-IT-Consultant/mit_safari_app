import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mit_safari_app/map/bloc/map_bloc.dart';

class MapActionButtons extends StatelessWidget {
  const MapActionButtons({
    super.key,
    required this.status,
  });
  final TrackingMode status;

  @override
  Widget build(BuildContext context) {
    final actionButtons = <Widget>[];
    if (status == TrackingMode.stopped) {
      actionButtons.add(
        FloatingActionButton(
          onPressed: () {
            context.read<MapBloc>().add(const StartTracking());
          },
          child: const Icon(
            Icons.play_arrow,
            semanticLabel: 'Play',
          ),
        ),
      );
    } else if (status == TrackingMode.tracking) {
      actionButtons.add(
        FloatingActionButton(
          onPressed: () {
            context.read<MapBloc>().add(const PauseTracking());
          },
          child: const Icon(
            Icons.pause,
            semanticLabel: 'Pause',
          ),
        ),
      );
    } else if (status == TrackingMode.paused) {
      actionButtons..add(
        FloatingActionButton(
          onPressed: () {
            context.read<MapBloc>().add(const ResumeTracking());
          },
          child: const Icon(
            Icons.motion_photos_pause,
            semanticLabel: 'Resume',
          ),
        ),
      )..add(
        FloatingActionButton(
          onPressed: () {
            context.read<MapBloc>().add(const StopTracking());
          },
          child: const Icon(
            Icons.stop,
            semanticLabel: 'Pause',
          ),
        ),
      );
    }

    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        children: [...actionButtons],
      ),
    );
  }
}
