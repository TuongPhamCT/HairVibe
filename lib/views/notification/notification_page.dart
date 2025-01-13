import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Singletons/notification_singleton.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/Utility.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/observers/notification_subcriber.dart';

import '../../Models/notice_model.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});
  static const String routeName = 'notifications_page';

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> implements NotificationSubscriber {
  final Map<String, List<String>> notifications = {};

  @override
  void initState() {
    NotificationSingleton singleton = NotificationSingleton.getInstance();
    singleton.subscribe(this);
    singleton.notifications.sort((element1, element2) => element1.date!.compareTo(element2.date!));

    for (NoticeModel model in singleton.notifications) {
      String date = Utility.formatDateFromDateTime(model.date);
      if (notifications.containsKey(date) == false) {
        notifications[date] = [];
      }
      notifications[date]?.add(model.content ?? "");
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    NotificationSingleton singleton = NotificationSingleton.getInstance();
    singleton.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          'NOTIFICATIONS',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
      ),
      body: notifications.isEmpty
          ? Column(
              children: [
                SizedBox(
                  width: size.width,
                ),
                Expanded(child: Container()),
                Image.asset(AssetHelper.noChat),
                const SizedBox(height: 20),
                Text(
                  'No notifications yet!!!',
                  style: TextDecor.homeTitle,
                ),
                const SizedBox(height: 40),
                Expanded(child: Container()),
              ],
            )
          : ListView(
              children: notifications.entries.map((entry) {
                final date = entry.key;
                final notis = entry.value;
                return ExpansionTile(
                  title: Text(
                    date,
                    style: TextDecor.robo23Semi,
                  ),
                  children: notis
                      .map((noti) => ListTile(
                            title: Text(
                              noti,
                              style: TextDecor.robo16Semi,
                            ),
                            leading: const Icon(
                              FontAwesomeIcons.solidBell,
                              color: Palette.primary,
                              size: 27,
                            ),
                          ))
                      .toList(),
                );
              }).toList(),
            ),
    );
  }

  @override
  void updateNotification() {
    NotificationSingleton singleton = NotificationSingleton.getInstance();
    singleton.notifications.sort((element1, element2) => element1.date!.compareTo(element2.date!));

    notifications.clear();
    for (NoticeModel model in singleton.notifications) {
      String date = Utility.formatDateFromDateTime(model.date);
      if (notifications.containsKey(date) == false) {
        notifications[date] = [];
      }
      notifications[date]?.add(model.content ?? "");
    }

    setState(() {});
  }
}
