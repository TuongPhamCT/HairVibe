import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/views/notification/notification_page.dart';

class NotificationBell extends StatelessWidget {
  final int soLuongThongBao;
  const NotificationBell({super.key, required this.soLuongThongBao});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 30),
      height: 30,
      width: 30,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).pushNamed(NotificationsPage.routeName);
            },
            icon: const Icon(
              FontAwesomeIcons.solidBell,
              color: Palette.primary,
              size: 27,
            ),
          ),
          if (soLuongThongBao > 0)
            Container(
              height: 16,
              width: 16,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$soLuongThongBao',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
