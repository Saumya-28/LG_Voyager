import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../connection/ssh.dart';
import '../utils/constants.dart';

class OrbitController {
  final WidgetRef ref;
  final BuildContext context;
  bool isPlaying = false;

  OrbitController({required this.ref, required this.context});

  Future<void> play(Function setState) async {
    isPlaying = true;
    setState();

    SSH(ref: ref).flyTo(
      context,
      Const.latitude,
      Const.longitude,
      Const.appZoomScale,
      0,
      0,
    );

    await Future.delayed(const Duration(milliseconds: 1000));

    for (int i = 0; i <= 360; i += 10) {
      if (!isPlaying) break;

      SSH(ref: ref).flyToOrbit(
        context,
        Const.latitude,
        Const.longitude,
        Const.orbitZoomScale,
        60,
        i.toDouble(),
      );
      await Future.delayed(const Duration(milliseconds: 1000));
    }

    SSH(ref: ref).flyTo(
      context,
      Const.latitude,
      Const.longitude,
      Const.appZoomScale,
      0,
      0,
    );

    isPlaying = false;
    setState();
  }

  Future<void> stop(Function setState) async {
    isPlaying = false;
    setState();

    SSH(ref: ref).flyTo(
      context,
      Const.latitude,
      Const.longitude,
      Const.appZoomScale,
      0,
      0,
    );
  }

  Future<void> toggle(Function setState) async {
    if (isPlaying) {
      await stop(setState);
    } else {
      await play(setState);
    }
  }
}

