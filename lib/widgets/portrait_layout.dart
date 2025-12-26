import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../widget/show_connection.dart';
import '../widgets/responsive_button.dart';

class PortraitLayout extends StatelessWidget {
  final bool connected;
  final double earthSize;
  final bool isSmallScreen;
  final double buttonFontSize;
  final GlobalKey connectedKey;
  final AnimationController earthController;
  final VoidCallback onEarthTap;
  final List<Map<String, dynamic>> buttons;

  const PortraitLayout({
    Key? key,
    required this.connected,
    required this.earthSize,
    required this.isSmallScreen,
    required this.buttonFontSize,
    required this.connectedKey,
    required this.earthController,
    required this.onEarthTap,
    required this.buttons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 20,
        vertical: isSmallScreen ? 12 : 20,
      ),
      child: Column(
        children: <Widget>[
          Container(
            key: connectedKey,
            margin: EdgeInsets.only(bottom: isSmallScreen ? 12 : 20),
            child: ShowConnection(status: connected),
          ),
          Container(
            constraints: BoxConstraints(
              maxHeight: earthSize,
              maxWidth: earthSize,
            ),
            margin: EdgeInsets.symmetric(vertical: isSmallScreen ? 16 : 24),
            child: GestureDetector(
              child: Lottie.asset(
                'assets/lottie/earth360.json',
                controller: earthController,
                fit: BoxFit.contain,
              ),
              onTap: onEarthTap,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 8 : 16),
            child: Column(
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
                SizedBox(height: isSmallScreen ? 10 : 16),
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
                SizedBox(height: isSmallScreen ? 10 : 16),
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
        ],
      ),
    );
  }
}

