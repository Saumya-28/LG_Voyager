import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartssh2/dartssh2.dart';
import '../connection/ssh.dart';

enum Planet {
  isEarth,
  isMoon,
  isMars,
}

class PlanetController {
  final WidgetRef ref;

  PlanetController({required this.ref});


}

