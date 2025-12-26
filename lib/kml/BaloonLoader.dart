import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../connection/SSH.dart';
import '../providers/connection_providers.dart';
import 'NamePlaceBallon.dart';

class BalloonLoader {
  WidgetRef ref;
  BuildContext context;
  bool mounted;

  BalloonLoader({
    required this.ref,
    required this.context,
    required this.mounted,
  });

  loadDashBoardBalloon() async {
    print('Loading Dashboard Balloon');

    // Check if connected before attempting to load
    if (!ref.read(connectedProvider)) {
      print('Not connected to SSH. Skipping balloon load.');
      return;
    }

    /*var initialMapPosition = CameraPosition(
      target: ref.read(cityDataProvider)!.location,
      zoom: Const.appZoomScale,
    );*/

    try {
      final result = await SSH(ref: ref).renderInSlave(
        context,
        ref.read(rightmostRigProvider),
        BalloonMakers.dashboardBalloon(),
      );

      if (mounted && ref.read(connectedProvider)) {
        ref.read(lastBalloonProvider.notifier).state = result;
      }
    } catch (error) {
      print('Error loading dashboard balloon: $error');
      // Connection state already updated in SSH class
    }
  }

  loadKmlBalloon(String kmlName, String fileSize) async {
    if (!ref.read(connectedProvider)) {
      print('Not connected to SSH. Skipping KML balloon load.');
      return;
    }

    try {
      String name = '<h3>Playing KML: $kmlName</h3>\n';
      String size = '<h3>KML file size: $fileSize</h3>\n';
      String processKml =
      ref.read(lastBalloonProvider).replaceAll('<img', '$name$size<img');
      await SSH(ref: ref)
          .renderInSlave(context, ref.read(rightmostRigProvider), processKml);
    } catch (error) {
      print('Error loading KML balloon: $error');
    }
  }

  restoreBalloon(String kmlName, String fileSize) async {
    if (!ref.read(connectedProvider)) {
      print('Not connected to SSH. Skipping balloon restore.');
      return;
    }

    try {
      await SSH(ref: ref).renderInSlave(context, ref.read(rightmostRigProvider),
          ref.read(lastBalloonProvider));
    } catch (error) {
      print('Error restoring balloon: $error');
    }
  }

}