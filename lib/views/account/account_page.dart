import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Singletons/notification_singleton.dart';
import 'package:hairvibe/Singletons/user_singleton.dart';
import 'package:hairvibe/Strategy/BottomBarStrategy/bottom_bar_strategy.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/facades/authenticator_facade.dart';
import 'package:hairvibe/observers/notification_subcriber.dart';
import 'package:hairvibe/views/account/about_us.dart';
import 'package:hairvibe/views/account/edit_account.dart';
import 'package:hairvibe/views/auth_screen.dart';
import 'package:hairvibe/widgets/noti_bell.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  static const routeName = 'account_page';

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> implements NotificationSubscriber {
  final AuthenticatorFacade _auth = AuthenticatorFacade();
  final NotificationSingleton _notificationSingleton = NotificationSingleton.getInstance();

  int _notificationCount = 2;

  BottomBarRenderStrategy? bottomBarRenderStrategy;

  @override
  void initState() {
    _notificationSingleton.subscribe(this);
    _notificationCount = _notificationSingleton.getUnreadCount();
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
    _notificationSingleton.unsubscribe(this);
    super.dispose();
  }

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
          NotificationBell(notificationCount: _notificationCount),
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
              onTap: () async {
                UserSingleton userSingleton = UserSingleton.getInstance();
                await _auth.signOut();
                await userSingleton.handleActionsAfterLogOut();
                if (context.mounted) {
                  Navigator.of(context).pushNamed(AuthScreen.routeName);
                }
              },
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
      bottomNavigationBar: bottomBarRenderStrategy?.render()
    );
  }

  @override
  void updateNotification() {
    setState(() {
      _notificationCount = _notificationSingleton.getUnreadCount();
    });
  }
}
