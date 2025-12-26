import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../kml/KmlMaker.dart';
import '../kml/NamePlaceBallon.dart';
import '../providers/connection_providers.dart';
import '../utils/constants.dart';
import '../widget/widgets.dart';

class SSH {
  final WidgetRef ref;

  SSH({required this.ref});

  SSHClient? _client;
  final CustomWidgets customWidgets = CustomWidgets();

  bool _isClientConnected() {
    final client = ref.read(sshClientProvider);
    if (client == null) {
      return false;
    }
    try {

      return client.isClosed == false;
    } catch (e) {
      return false;
    }
  }

  Future<void> _forceRefresh(int screen) async {
    try {
      final client = ref.read(sshClientProvider);
      if (client != null && _isClientConnected()) {

        await client.execute(
          'echo "http://lg1:81/kml/slave_$screen.kml" > /var/www/html/kmls.txt',
        );


        await Future.delayed(const Duration(milliseconds: 50));


        await client.execute(
          'echo "search=http://lg1:81/kmls.txt" > /tmp/query.txt',
        );
      }
    } catch (e) {
      print('Error during force refresh: $e');
    }
  }

  Future<void> cleanBalloonKML() async {
    try {
      final client = ref.read(sshClientProvider);
      if (client != null && _isClientConnected()) {
        int rightScreen = ref.read(rightmostRigProvider);
        String blankKml = BalloonMakers.blankBalloon();
        await client.execute(
          "echo '$blankKml' > /var/www/html/kml/slave_$rightScreen.kml",
        );
      }
    } catch (e) {
      print('Error cleaning balloon KML: $e');
    }
  }

   renderInSlave(context, int slaveNo, String kml) async {
    try {
      final client = ref.read(sshClientProvider);
      if (client == null || !_isClientConnected()) {
        throw Exception('SSH connection is not available. Please reconnect.');
      }
      await client.run("echo '$kml' > /var/www/html/kml/slave_$slaveNo.kml");
      return kml;
    } catch (error) {

      if (error.toString().contains('Transport is closed') ||
          error.toString().contains('SSHStateError')) {
        ref.read(connectedProvider.notifier).state = false;
        customWidgets.showSnackBar(
            context: context,
            message: 'SSH connection lost. Please reconnect.',
            color: Colors.red);
      } else {
        customWidgets.showSnackBar(
            context: context, message: error.toString(), color: Colors.red);
      }
      return BalloonMakers.blankBalloon();
    }
  }

  Future<bool> cleanKML(context) async {
    try {
      if (!_isClientConnected()) {
        print('SSH connection is not available.');
        customWidgets.showSnackBar(
            context: context,
            message: 'SSH connection is not available. Please reconnect.',
            color: Colors.red);
        return false;
      }


      await stopOrbit(context);


      await ref.read(sshClientProvider)?.execute('echo "" > /tmp/query.txt');


      String blankKml = BalloonMakers.blankBalloon();
      await ref.read(sshClientProvider)?.execute(
          "echo '$blankKml' > /var/www/html/kml/slave_${ref.read(rightmostRigProvider)}.kml");

      print('KML cleaned successfully');
      return true;
    } catch (error) {
      if (error.toString().contains('Transport is closed') ||
          error.toString().contains('SSHStateError')) {
        ref.read(connectedProvider.notifier).state = false;
        customWidgets.showSnackBar(
            context: context,
            message: 'SSH connection lost. Please reconnect.',
            color: Colors.red);
      } else {
        customWidgets.showSnackBar(
            context: context, message: error.toString(), color: Colors.red);
      }
      return false;
    }
  }

  Future<bool> cleanBalloon(context) async {
    try {
      if (!_isClientConnected()) {
        print('SSH connection is not available.');
        customWidgets.showSnackBar(
            context: context,
            message: 'SSH connection is not available. Please reconnect.',
            color: Colors.red);
        return false;
      }

      await ref.read(sshClientProvider)?.execute(
          "echo '${BalloonMakers.blankBalloon()}' > /var/www/html/kml/slave_${ref.read(leftmostRigProvider)}.kml");

      print('Balloon cleaned successfully');
      return true;
    } catch (error) {
      if (error.toString().contains('Transport is closed') ||
          error.toString().contains('SSHStateError')) {
        ref.read(connectedProvider.notifier).state = false;
        customWidgets.showSnackBar(
            context: context,
            message: 'SSH connection lost. Please reconnect.',
            color: Colors.red);
      } else {
        print('Error cleaning balloon: $error');
      }
      return false;
    }
  }

  Future<bool?> connectToLG(BuildContext context) async {
    try {
      final socket = await SSHSocket.connect(
          ref.read(ipProvider), ref.read(portProvider),
          timeout: const Duration(seconds: 5));
      ref.read(sshClientProvider.notifier).state = SSHClient(
        socket,
        username: ref.read(usernameProvider),
        onPasswordRequest: () => ref.read(passwordProvider),
      );
      ref.read(connectedProvider.notifier).state = true;
      return true;
    } catch (e) {
      ref.read(connectedProvider.notifier).state = false;
      print('Failed to connect: $e');
      customWidgets.showSnackBar(
          context: context, message: e.toString(), color: Colors.red);
      return false;
    }
  }

  Future<void> disconnect() async {
    try {
      final client = ref.read(sshClientProvider);
      if (client != null && !client.isClosed) {
        client.close();
      }
    } catch (e) {
      print('Error during disconnect: $e');
    } finally {
      ref.read(sshClientProvider.notifier).state = null;
      ref.read(connectedProvider.notifier).state = false;
    }
  }

  Future<bool> showLGLogo() async {
    try {
      _client = ref.read(sshClientProvider);
      if (_client == null || !_isClientConnected()) {
        print('SSH client is not initialized or disconnected.');
        return false;
      }

      int leftScreen = ref.read(leftmostRigProvider);
      String logoKml = KMLMakers.screenOverlayImage(
        Const.lgLogoLink,
        Const.logoAspectRatio,
      );

      await _client!.execute(
        "echo '$logoKml' > /var/www/html/kml/slave_$leftScreen.kml"
      );

      print('LG Logo displayed on left screen (slave_$leftScreen)');
      return true;
    } catch (e) {
      if (e.toString().contains('Transport is closed') ||
          e.toString().contains('SSHStateError')) {
        ref.read(connectedProvider.notifier).state = false;
      }
      print('Failed to show LG logo: $e');
      return false;
    }
  }

  Future<bool> cleanLogos() async {
    try {
      _client = ref.read(sshClientProvider);
      if (_client == null || !_isClientConnected()) {
        print('SSH client is not initialized or disconnected.');
        return false;
      }

      int leftScreen = ref.read(leftmostRigProvider);


      String emptyKml = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
    <name>Empty</name>
  </Document>
</kml>''';

      await _client!.execute(
        "echo '$emptyKml' > /var/www/html/kml/slave_$leftScreen.kml"
      );

      print('Logos cleaned successfully from left screen (slave_$leftScreen)');
      return true;
    } catch (e) {
      if (e.toString().contains('Transport is closed') ||
          e.toString().contains('SSHStateError')) {
        ref.read(connectedProvider.notifier).state = false;
      }
      print('Failed to clean logos: $e');
      return false;
    }
  }

  Future<bool> sendBallonKml(String kmlContent) async {
    try {
      _client = ref.read(sshClientProvider);
      if (_client == null || !_isClientConnected()) {
        print('SSH client is not initialized or disconnected.');
        return false;
      }

      int rightScreen = ref.read(rightmostRigProvider);

      final writeKmlCommand = '''
cat << 'EOF' > /var/www/html/kml/slave_$rightScreen.kml
$kmlContent
EOF
''';

      await _client!.execute(writeKmlCommand);
      print('KML sent to slave_$rightScreen successfully');
      return true;
    } catch (e) {
      if (e.toString().contains('Transport is closed') ||
          e.toString().contains('SSHStateError')) {
        ref.read(connectedProvider.notifier).state = false;
      }
      print('Failed to send KML: $e');
      return false;
    }
  }

  Future<bool> showKML1(BuildContext context) async {
    try {
      _client = ref.read(sshClientProvider);
      if (_client == null || !_isClientConnected()) {
        print('SSH client is not initialized or disconnected.');
        return false;
      }

      // location for Kml 1
      const double zoom = 2000.0;
      const double tilt = 45.0;
      const double bearing = 0.0;

      bool flySuccess = await flyTo(
        context,
        KMLMakers.kml1Latitude,
        KMLMakers.kml1Longitude,
        zoom,
        tilt,
        bearing,
      );

      if (!flySuccess) {
        print('Failed to fly to ${KMLMakers.kml1Name}');
        return false;
      }


      await Future.delayed(const Duration(milliseconds: 2000));


      int rightScreen = ref.read(rightmostRigProvider);
      String kml1File = 'slave_${rightScreen}_kml1.kml';


      String kmlContent = KMLMakers.createKML1();

      String writeCommand = '''cat > /var/www/html/kml/$kml1File << 'EOFKML'
$kmlContent
EOFKML''';

      await _client!.execute(writeCommand);
      print('KML 1 written to $kml1File');


      await Future.delayed(const Duration(milliseconds: 200));


      await _client!.execute(
        'grep -q "kml1.kml" /var/www/html/kmls.txt 2>/dev/null || echo "http://lg1:81/kml/$kml1File" >> /var/www/html/kmls.txt',
      );

      print('KML 1 registered in kmls.txt');


      await Future.delayed(const Duration(milliseconds: 200));


      await _client!.execute(
        'echo "search=http://lg1:81/kmls.txt" > /tmp/query.txt',
      );

      print('KML 1 displayed at ${KMLMakers.kml1Name}');
      return true;
    } catch (e) {
      if (e.toString().contains('Transport is closed') ||
          e.toString().contains('SSHStateError')) {
        ref.read(connectedProvider.notifier).state = false;
      }
      print('Failed to show KML 1: $e');
      return false;
    }
  }
  Future<bool> showKML2(BuildContext context) async {
    try {
      _client = ref.read(sshClientProvider);
      if (_client == null || !_isClientConnected()) {
        print('SSH client is not initialized or disconnected.');
        return false;
      }

      //KML2 location
      const double zoom = 2000.0;
      const double tilt = 45.0;
      const double bearing = 0.0;

      bool flySuccess = await flyTo(
        context,
        KMLMakers.kml2Latitude,
        KMLMakers.kml2Longitude,
        zoom,
        tilt,
        bearing,
      );

      if (!flySuccess) {
        print('Failed to fly to ${KMLMakers.kml2Name}');
        return false;
      }


      await Future.delayed(const Duration(milliseconds: 2000));


      int rightScreen = ref.read(rightmostRigProvider);
      String kml2File = 'slave_${rightScreen}_kml2.kml';


      String kmlContent = KMLMakers.createKML2();

      String writeCommand = '''cat > /var/www/html/kml/$kml2File << 'EOFKML'
$kmlContent
EOFKML''';

      await _client!.execute(writeCommand);
      print('KML 2 written to $kml2File');


      await Future.delayed(const Duration(milliseconds: 200));


      await _client!.execute(
        'grep -q "kml2.kml" /var/www/html/kmls.txt 2>/dev/null || echo "http://lg1:81/kml/$kml2File" >> /var/www/html/kmls.txt',
      );

      print('KML 2 registered in kmls.txt');


      await Future.delayed(const Duration(milliseconds: 200));


      await _client!.execute(
        'echo "search=http://lg1:81/kmls.txt" > /tmp/query.txt',
      );

      print('KML 2 displayed at ${KMLMakers.kml2Name}');
      return true;
    } catch (e) {
      if (e.toString().contains('Transport is closed') ||
          e.toString().contains('SSHStateError')) {
        ref.read(connectedProvider.notifier).state = false;
      }
      print('Failed to show KML 2: $e');
      return false;
    }
  }


  Future<bool> cleanKMLs() async {
    try {
      _client = ref.read(sshClientProvider);
      if (_client == null || !_isClientConnected()) {
        print('SSH client is not initialized or disconnected.');
        return false;
      }

      int rightScreen = ref.read(rightmostRigProvider);


      String query = 'echo "exittour=true" > /tmp/query.txt && > /var/www/html/kmls.txt';
      await _client!.execute(query);


      await _client!.execute('rm -f /var/www/html/kml/slave_${rightScreen}_kml1.kml');
      await _client!.execute('rm -f /var/www/html/kml/slave_${rightScreen}_kml2.kml');

      print('KMLs cleaned successfully (both KML1 and KML2)');
      return true;
    } catch (e) {
      if (e.toString().contains('Transport is closed') ||
          e.toString().contains('SSHStateError')) {
        ref.read(connectedProvider.notifier).state = false;
      }
      print('Failed to clean KMLs: $e');
      return false;
    }
  }

  Future<bool> cleanKMLsAndVisualization({bool keepLogo = false}) async {
    bool allSuccessful = true;

    try {
      _client = ref.read(sshClientProvider);
      if (_client == null || !_isClientConnected()) {
        print('SSH client is not initialized or disconnected.');
        return false;
      }


      String query = 'echo "exittour=true" > /tmp/query.txt && > /var/www/html/kmls.txt';
      try {
        await _client!.execute(query);
        print('Liquid Galaxy exited tour and cleared kmls.txt successfully');
      } catch (e) {
        print('Failed to exit tour and clear kmls.txt: $e');
        allSuccessful = false;
      }


      int screens = ref.read(rigsProvider);
      for (int i = 2; i <= screens; i++) {
        String kmlContent = BalloonMakers.blankBalloon();
        final clearCommand = "echo '$kmlContent' > /var/www/html/kml/slave_$i.kml";

        try {
          await _client!.execute(clearCommand);
          print('Liquid Galaxy cleared KML from slave $i successfully');
        } catch (e) {
          print('Failed to clear KML from slave $i: $e');
          allSuccessful = false;
        }
      }


      if (!keepLogo) {
        final logoCleanResult = await cleanLogos();
        allSuccessful = allSuccessful && logoCleanResult;
      }

      return allSuccessful;
    } catch (e) {
      if (e.toString().contains('Transport is closed') ||
          e.toString().contains('SSHStateError')) {
        ref.read(connectedProvider.notifier).state = false;
      }
      print('Failed to clean KMLs and visualization: $e');
      return false;
    }
  }

  Future<SSHSession?> search(String place) async {
    try {
      _client = ref.read(sshClientProvider);
      if (_client == null || !_isClientConnected()) {
        print('SSH client is not initialized or disconnected.');
        return null;
      }
      final session = await _client!.execute('echo "search=$place" >/tmp/query.txt');
      return session;
    } catch (e) {
      if (e.toString().contains('Transport is closed') ||
          e.toString().contains('SSHStateError')) {
        ref.read(connectedProvider.notifier).state = false;
      }
      print('An error occurred while executing the command: $e');
      return null;
    }
  }

  Future<bool> flyTo(BuildContext context, double latitude, double longitude,
      double zoom, double tilt, double bearing) async {
    try {
      _client = ref.read(sshClientProvider);
      if (_client == null || !_isClientConnected()) {
        print('SSH client is not initialized or disconnected.');
        return false;
      }

      String flyToCommand = 'echo "flytoview=${KMLMakers.lookAtLinear(
        latitude, longitude, zoom, tilt, bearing
      )}" > /tmp/query.txt';

      await _client!.execute(flyToCommand);
      print('Flew to: $latitude, $longitude');
      return true;
    } catch (e) {
      if (e.toString().contains('Transport is closed') ||
          e.toString().contains('SSHStateError')) {
        ref.read(connectedProvider.notifier).state = false;
      }
      print('Failed to fly to location: $e');
      return false;
    }
  }

  Future<bool> flyToOrbit(BuildContext context, double latitude, double longitude,
      double zoom, double tilt, double bearing) async {
    try {
      _client = ref.read(sshClientProvider);
      if (_client == null || !_isClientConnected()) {
        print('SSH client is not initialized or disconnected.');
        return false;
      }

      String orbitCommand = 'echo "flytoview=${KMLMakers.orbitLookAtLinear(
        latitude, longitude, zoom, tilt, bearing
      )}" > /tmp/query.txt';

      await _client!.execute(orbitCommand);
      print('Started orbit successfully');
      return true;
    } catch (e) {
      if (e.toString().contains('Transport is closed') ||
          e.toString().contains('SSHStateError')) {
        ref.read(connectedProvider.notifier).state = false;
      }
      print('Failed to orbit: $e');
      return false;
    }
  }

  Future<bool> initialConnect({int i = 0}) async {
    try {
      _client = ref.read(sshClientProvider);
      if (_client == null || !_isClientConnected()) {
        print('SSH client is not initialized or disconnected.');
        return false;
      }

      if (i == 0) {
        int leftScreen = ref.read(leftmostRigProvider);
        String logoKml = KMLMakers.screenOverlayImage(
          Const.overLayImageLink,
          Const.splashAspectRatio,
        );

        await _client!.execute(
          "echo '$logoKml' > /var/www/html/kml/slave_$leftScreen.kml"
        );
        print('Initial connection setup completed');
      }
      return true;
    } catch (e) {
      if (e.toString().contains('Transport is closed') ||
          e.toString().contains('SSHStateError')) {
        ref.read(connectedProvider.notifier).state = false;
      }
      print('Failed to initialize connection: $e');
      return false;
    }
  }

  Future<bool> relunchLG() async {
    try {
      _client = ref.read(sshClientProvider);
      if (_client == null || !_isClientConnected()) {
        print('SSH client is not initialized or disconnected.');
        return false;
      }

      for (var i = 1; i <= ref.read(rigsProvider); i++) {
        String cmd = """RELAUNCH_CMD="\\
          if [ -f /etc/init/lxdm.conf ]; then
            export SERVICE=lxdm
          elif [ -f /etc/init/lightdm.conf ]; then
            export SERVICE=lightdm
          else
            exit 1
          fi
          if  [[ \\\$(service \\\$SERVICE status) =~ 'stop' ]]; then
            echo ${ref.read(passwordProvider)} | sudo -S service \\\${SERVICE} start
          else
            echo ${ref.read(passwordProvider)} | sudo -S service \\\${SERVICE} restart
          fi
          " && sshpass -p ${ref.read(passwordProvider)} ssh -x -t lg@lg$i "\$RELAUNCH_CMD\"""";

        await _client!.execute(
            '"/home/${ref.read(usernameProvider)}/bin/lg-relaunch" > /home/${ref.read(usernameProvider)}/log.txt');
        await _client!.execute(cmd);
      }

      print('LG relaunch completed successfully');
      return true;
    } catch (e) {
      if (e.toString().contains('Transport is closed') ||
          e.toString().contains('SSHStateError')) {
        ref.read(connectedProvider.notifier).state = false;
      }
      print('An error occurred while relaunching LG: $e');
      return false;
    }
  }

  Future<bool> stopOrbit(context) async {
    try {
      if (!_isClientConnected()) {
        print('SSH client is not connected.');
        return false;
      }
      await ref.read(sshClientProvider)?.execute('echo "exittour=true" > /tmp/query.txt');
      print('Orbit stopped successfully');
      return true;
    } catch (error) {
      if (error.toString().contains('Transport is closed') ||
          error.toString().contains('SSHStateError')) {
        ref.read(connectedProvider.notifier).state = false;
      }
      print('Error stopping orbit: $error');
      return false;
    }
  }
}