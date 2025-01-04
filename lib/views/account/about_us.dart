import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/bottom_bar.dart';
import 'package:hairvibe/widgets/noti_bell.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});
  static const String routeName = 'about_us_page';

  @override
  Widget build(BuildContext context) {
    int _soLuongThongBao = 2;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Palette.primary,
          ),
        ),
        backgroundColor: Colors.black,
        title: Text(
          'ABOUT US',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          NotificationBell(notificationCount: _soLuongThongBao),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(child: Container()),
            Text('HairVibe', style: TextDecor.appName),
            const SizedBox(height: 20),
            Text('No 1. Hair Salon in Vietnam', style: TextDecor.homeTitle),
            const SizedBox(height: 40),
            Expanded(child: Container()),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarCustom(currentIndex: 3),
    );
  }
}
