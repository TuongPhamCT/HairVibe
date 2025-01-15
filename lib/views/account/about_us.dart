import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Singletons/notification_singleton.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/observers/notification_subcriber.dart';
import 'package:hairvibe/widgets/noti_bell.dart';

import '../../Singletons/user_singleton.dart';
import '../../Strategy/BottomBarStrategy/bottom_bar_strategy.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});
  static const String routeName = 'about_us_page';

  @override
  State<AboutUs> createState() => AboutUsState();
}

class AboutUsState extends State<AboutUs> implements NotificationSubscriber {
  final NotificationSingleton singleton = NotificationSingleton.getInstance();
  int _soLuongThongBao = 2;

  BottomBarRenderStrategy? bottomBarRenderStrategy;

  @override
  void initState() {
    singleton.subscribe(this);
    _soLuongThongBao = singleton.getUnreadCount();

    UserSingleton userSingleton = UserSingleton.getInstance();
    if (userSingleton.currentUserIsCustomer()) {
      bottomBarRenderStrategy = userSingleton.getBottomBarRenderStrategy(3);
    } else {
      bottomBarRenderStrategy = userSingleton.getBottomBarRenderStrategy(4);
    }

    super.initState();
  }

  @override
  void dispose() {
    singleton.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
      bottomNavigationBar: bottomBarRenderStrategy?.render(),
    );
  }

  @override
  void updateNotification() {
    setState(() {
      _soLuongThongBao = singleton.getUnreadCount();
    });
  }
}
