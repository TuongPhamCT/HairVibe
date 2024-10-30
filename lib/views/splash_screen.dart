import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String routeName = 'splash_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Image.asset(
              AssetHelper.logo,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 180),
            child: Text(
              'Hair Vibe',
              style: TextDecor.title,
            ),
          ),
        ],
      ),
    );
  }
}
