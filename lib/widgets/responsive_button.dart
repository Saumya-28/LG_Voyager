import 'package:flutter/material.dart';
import '../utils/theme.dart';

class ResponsiveButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSmallScreen;
  final double fontSize;

  const ResponsiveButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isSmallScreen,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: isSmallScreen ? 70 : 90,
        maxHeight: isSmallScreen ? 110 : 140,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(ThemesDark().tabBarColor),
          foregroundColor: WidgetStateProperty.all(ThemesDark().oppositeColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isSmallScreen ? 18 : 28),
            ),
          ),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 16 : 20,
              vertical: isSmallScreen ? 14 : 18,
            ),
          ),
          elevation: WidgetStateProperty.all(4),
          shadowColor: WidgetStateProperty.all(
            Colors.black.withAlpha(100),
          ),
        ),
        onPressed: onPressed,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

class ButtonRow extends StatelessWidget {
  final bool isSmallScreen;
  final List<Widget> buttons;

  const ButtonRow({
    Key? key,
    required this.isSmallScreen,
    required this.buttons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((button) => Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 6 : 10),
          child: button,
        ),
      )).toList(),
    );
  }
}

