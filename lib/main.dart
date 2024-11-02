import 'package:flutter/material.dart';
import 'package:hairvibe/views/auth_screen.dart';
import 'package:hairvibe/views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hair Vibe',
      home: AuthScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
