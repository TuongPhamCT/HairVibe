import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairvibe/component/dependency_injection.dart';
import 'package:hairvibe/config/firebase_options.dart';
import 'package:hairvibe/router.dart';
import 'package:hairvibe/views/auth_screen.dart';
import 'package:hairvibe/views/admin/home_screen.dart';
import 'package:hairvibe/views/admin_contact/contact_list.dart';
import 'package:hairvibe/views/barber/home_screen.dart';
import 'package:hairvibe/views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hair Vibe',
      home: const SplashScreen(),
      //home: const AdminContactListPage(),
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}
