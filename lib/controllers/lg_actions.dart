import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartssh2/dartssh2.dart';
import '../connection/ssh.dart';
import '../providers/connection_providers.dart';

class LGActions {
  final WidgetRef ref;
  final BuildContext context;
  final bool mounted;

  LGActions({
    required this.ref,
    required this.context,
    required this.mounted,
  });

  Future<void> showLGLogo() async {
    bool success = await SSH(ref: ref).showLGLogo();
    if (success) {
      print('LG Logo displayed successfully');
    }
  }

  Future<void> cleanLogos() async {
    bool success = await SSH(ref: ref).cleanLogos();
    if (success) {
      print('Logos cleaned successfully');
    }
  }

  Future<void> showKML1() async {
    bool success = await SSH(ref: ref).showKML1(context);
    if (success) {
      print('KML 1 displayed successfully at ${SSH(ref: ref)}');
    }
  }

  Future<void> showKML2() async {
    bool success = await SSH(ref: ref).showKML2(context);
    if (success) {
      print('KML 2 displayed successfully');
    }
  }

  Future<void> cleanKMLs() async {
    bool success = await SSH(ref: ref).cleanKMLs();
    if (success) {
      print('KMLs cleaned successfully');
    }
  }

  Future<void> relaunchLG() async {
    await SSH(ref: ref).relunchLG();
  }

  void showRelaunchDialog(BuildContext context) {
    _showAlertDialog(context, 1);
  }

  void showDisconnectDialog(BuildContext context) {
    _showAlertDialog(context, 2);
  }

  void _showAlertDialog(BuildContext context, int ind) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop();
        if (ind == 1) {
          relaunchLG();
        } else if (ind == 2) {
          ref.read(connectedProvider.notifier).state = false;
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Confirmation"),
      content: Text((ind == 1)
          ? "Are you sure you want to relaunch LG?"
          : "Are you sure you want to disconnect from LG?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

