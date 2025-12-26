import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lg/pages/splash_screen.dart';
import 'package:lg/utils/string_constants.dart';
import 'package:lg/utils/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    final themesDark = ThemesDark();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.appName,
      theme: themesDark.themeData.copyWith(
        textTheme: themesDark.themeData.textTheme.apply(
          fontFamily: 'GoogleSans',
        ),
      ),
      home: const SplashScreen(),
    );
  }
}