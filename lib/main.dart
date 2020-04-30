import 'package:flutter/material.dart';
import './screens/Onboarding_screen.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
      theme: ThemeData(appBarTheme: AppBarTheme(color: Color(0xFF192A56))),
    );
  }
}
