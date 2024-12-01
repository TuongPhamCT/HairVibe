import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});
  static const String routeName = 'notifications_page';

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final Map<String, List<String>> notifications = {
    // comment để thử nghiệm khi không có thông báo:
    '01/12/2024': [
      'Noti 1 dasdfasdfa dsf adfadsfasdf adf asddfjaadjasflksdfasdljk asdfadsafasfas asdfdsfweffasd fads fasfdfas dfsfd asdfa sfsfsadfas sdafdasdfaafdsf',
      'Noti 2',
      'Noti 3'
    ],
    '30/11/2024': ['Noti 1'],
    '29/11/2024': ['Noti 1', 'Noti 2', 'Noti 3', 'Noti 4'],
  };
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
}
