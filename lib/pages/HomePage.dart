
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lg/pages/settings.dart';
import 'package:particles_flutter/particles_flutter.dart';

import '../connection/ssh.dart';
import '../controllers/lg_actions.dart';
import '../providers/connection_providers.dart';
import '../utils/theme.dart';
import '../widgets/portrait_layout.dart';
import '../widgets/landscape_layout.dart';

final settingsKey = GlobalKey();

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with TickerProviderStateMixin {
  late AnimationController _earthController;
  late AnimationController _moonController;
  late AnimationController _marsController;
  late LGActions _lgActions;

  GlobalKey connectedKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _earthController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _moonController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _marsController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _earthController.stop();
    _moonController.stop();
    _marsController.stop();


    SSH(ref: ref).flyTo(context, 40.730610, -73.935242, 11, 0.0, 0.0);
    SSH(ref: ref).initialConnect();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _lgActions = LGActions(ref: ref, context: context, mounted: mounted);
  }

  @override
  void dispose() {
    _earthController.dispose();
    _moonController.dispose();
    _marsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool connected = ref.watch(connectedProvider);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isSmallScreen = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1024;

    double earthSize = isPortrait
        ? (isSmallScreen ? screenWidth * 0.7 : screenWidth * 0.5)
        : (isSmallScreen ? screenHeight * 0.5 : screenHeight * 0.6);

    double particleCount = isSmallScreen ? 300.0 : 600.0;
    double titleFontSize = isSmallScreen ? 18 : (isTablet ? 20 : 24);
    double buttonFontSize = isSmallScreen ? 13 : (isTablet ? 16 : 18);

    final buttons = [
      {'text': 'Show KML 1', 'onPressed': _lgActions.showKML1},
      {'text': 'Show KML 2', 'onPressed': _lgActions.showKML2},
      {'text': 'Clean KMLs', 'onPressed': _lgActions.cleanKMLs},
      {'text': 'Show LG Logo', 'onPressed': _lgActions.showLGLogo},
      {'text': 'Clean Logos', 'onPressed': _lgActions.cleanLogos},
      {'text': 'Relaunch LG', 'onPressed': () => _lgActions.showRelaunchDialog(context)},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemesDark().tabBarColor,
        title: Text(
          "Lg Voyager",
          style: TextStyle(
            color: ThemesDark().oppositeColor,
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConnectionScreen(),
                ),
              );
            },
            color: ThemesDark().oppositeColor,
          )
        ],
      ),
      body: Stack(
        children: [
          CircularParticle(
            key: UniqueKey(),
            awayRadius: isSmallScreen ? 40 : 60,
            numberOfParticles: particleCount,
            speedOfParticles: 1,
            height: screenHeight,
            width: screenWidth,
            onTapAnimation: true,
            particleColor: Colors.white.withAlpha(150),
            awayAnimationDuration: Duration(milliseconds: 600),
            maxParticleSize: isSmallScreen ? 1.5 : 2,
            isRandSize: true,
            isRandomColor: true,
            randColorList: [
              Colors.white.withAlpha(50),
              Colors.white.withAlpha(50),
            ],
            awayAnimationCurve: Curves.ease,
            enableHover: true,
            hoverColor: Colors.white.withAlpha(80),
            hoverRadius: isSmallScreen ? 60 : 90,
            connectDots: false,
          ),
          SafeArea(
            child: isPortrait
                ? PortraitLayout(
                    connected: connected,
                    earthSize: earthSize,
                    isSmallScreen: isSmallScreen,
                    buttonFontSize: buttonFontSize,
                    connectedKey: connectedKey,
                    earthController: _earthController,
                    onEarthTap: _handleEarthTap,
                    buttons: buttons,
                  )
                : LandscapeLayout(
                    connected: connected,
                    earthSize: earthSize,
                    isSmallScreen: isSmallScreen,
                    buttonFontSize: buttonFontSize,
                    screenHeight: screenHeight,
                    connectedKey: connectedKey,
                    earthController: _earthController,
                    onEarthTap: _handleEarthTap,
                    buttons: buttons,
                  ),
          ),
        ],
      ),
    );
  }

  void _handleEarthTap() async {
    _earthController.repeat();
    _moonController.stop();
    _marsController.stop();
    setState(() {});
  }
}

