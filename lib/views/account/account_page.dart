import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/account/about_us.dart';
import 'package:hairvibe/views/account/edit_account.dart';
import 'package:hairvibe/widgets/bottom_bar.dart';
import 'package:hairvibe/widgets/noti_bell.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  static const routeName = 'account_page';

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _currentPageIndex = 3;
  int _soLuongThongBao = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'ACCOUNT',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          NotificationBell(soLuongThongBao: _soLuongThongBao),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(EditAccount.routeName);
              },
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.gear,
                    color: Palette.primary,
                    size: 30,
                  ),
                  const SizedBox(width: 20),
                  Text('Manage Account', style: TextDecor.homeTitle),
                ],
              ),
            ),
            const SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AboutUs.routeName);
              },
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.infoCircle,
                    color: Palette.primary,
                    size: 30,
                  ),
                  const SizedBox(width: 20),
                  Text('About us', style: TextDecor.homeTitle),
                ],
              ),
            ),
            const SizedBox(height: 40),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(
                    Icons.logout_rounded,
                    color: Palette.primary,
                    size: 30,
                  ),
                  const SizedBox(width: 20),
                  Text('Log out', style: TextDecor.homeTitle),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarCustom(
        currentIndex: _currentPageIndex,
      ),
    );
  }
}
