import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../widget/show_connection.dart';
import '../widgets/responsive_button.dart';

class LandscapeLayout extends StatelessWidget {
  final bool connected;
  final double earthSize;
  final bool isSmallScreen;
  final double buttonFontSize;
  final double screenHeight;
  final GlobalKey connectedKey;
  final AnimationController earthController;
  final VoidCallback onEarthTap;
  final List<Map<String, dynamic>> buttons;

  const LandscapeLayout({
    super.key,
    required this.connected,
    required this.earthSize,
    required this.isSmallScreen,
    required this.buttonFontSize,
    required this.screenHeight,
    required this.connectedKey,
    required this.earthController,
    required this.onEarthTap,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 24,
        vertical: isSmallScreen ? 8 : 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  key: connectedKey,
                  margin: EdgeInsets.only(bottom: isSmallScreen ? 8 : 16),
                  child: ShowConnection(status: connected),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: earthSize,
                    maxWidth: earthSize,
                  ),
                  child: GestureDetector(
                    onTap: onEarthTap,
                    child: Lottie.asset(
                      'assets/lottie/earth360.json',
                      controller: earthController,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: isSmallScreen ? 12 : 24),
          Expanded(
            flex: 3,
            child: Container(
              constraints: BoxConstraints(
                minHeight: screenHeight * 0.7,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonRow(
                    isSmallScreen: isSmallScreen,
                    buttons: [
                      ResponsiveButton(
                        text: buttons[0]['text'],
                        onPressed: buttons[0]['onPressed'],
                        isSmallScreen: isSmallScreen,
                        fontSize: buttonFontSize,
                      ),
                      ResponsiveButton(
                        text: buttons[1]['text'],
                        onPressed: buttons[1]['onPressed'],
                        isSmallScreen: isSmallScreen,
                        fontSize: buttonFontSize,
                      ),
                    ],
                  ),
                  SizedBox(height: isSmallScreen ? 12 : 20),
                  ButtonRow(
                    isSmallScreen: isSmallScreen,
                    buttons: [
                      ResponsiveButton(
                        text: buttons[2]['text'],
                        onPressed: buttons[2]['onPressed'],
                        isSmallScreen: isSmallScreen,
                        fontSize: buttonFontSize,
                      ),
                      ResponsiveButton(
                        text: buttons[3]['text'],
                        onPressed: buttons[3]['onPressed'],
                        isSmallScreen: isSmallScreen,
                        fontSize: buttonFontSize,
                      ),
                    ],
                  ),
                  SizedBox(height: isSmallScreen ? 12 : 20),
                  ButtonRow(
                    isSmallScreen: isSmallScreen,
                    buttons: [
                      ResponsiveButton(
                        text: buttons[4]['text'],
                        onPressed: buttons[4]['onPressed'],
                        isSmallScreen: isSmallScreen,
                        fontSize: buttonFontSize,
                      ),
                      ResponsiveButton(
                        text: buttons[5]['text'],
                        onPressed: buttons[5]['onPressed'],
                        isSmallScreen: isSmallScreen,
                        fontSize: buttonFontSize,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

