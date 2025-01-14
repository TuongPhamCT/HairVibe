import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/views/admin_appointment/appointment_calendar.dart';
import 'package:hairvibe/views/admin/admin_home_screen.dart';
import 'package:hairvibe/views/admin_contact/contact_list.dart';
import 'package:hairvibe/views/admin_management/comment.dart';

import '../Singletons/user_singleton.dart';
import '../views/account/account_page.dart';

class AdminBottomBar extends StatefulWidget {
  final int currentIndex;
  const AdminBottomBar({super.key, required this.currentIndex});

  @override
  State<AdminBottomBar> createState() => _AdminBottomBarState();
}

class _AdminBottomBarState extends State<AdminBottomBar> {
  void _navigateWithoutAnimation(BuildContext context, String routeName) {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          _getPage(routeName),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ));
  }

  Widget _getPage(String routeName) {
    switch (routeName) {
      case AdminHomeScreen.routeName:
        return const AdminHomeScreen();
      case AdminAppointmentPage.routeName:
        return const AdminAppointmentPage();
      case AdminContactListPage.routeName:
        return const AdminContactListPage();
      case AdminCommentPage.routeName:
        return const AdminCommentPage();
      case AccountPage.routeName:
        return const AccountPage();
      default:
        return const AdminHomeScreen(); // Default page
    }
  }

  @override
  Widget build(BuildContext context) {
    String namePrefix = UserSingleton.getInstance().currentUser!.name!.characters.first;

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Palette.primary,
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.currentIndex,
        onTap: (value) {
          switch (value) {
            case 0:
              _navigateWithoutAnimation(context, AdminHomeScreen.routeName);
              break;
            case 1:
              _navigateWithoutAnimation(
                  context, AdminAppointmentPage.routeName);
              break;
            case 2:
              _navigateWithoutAnimation(
                  context, AdminContactListPage.routeName);
              break;
            case 3:
              _navigateWithoutAnimation(context, AdminCommentPage.routeName);
            case 4:
              _navigateWithoutAnimation(context, AccountPage.routeName);
              break;
          }
        },
        backgroundColor: Colors.black,
        selectedItemColor: Palette.primary,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.houseChimney),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidCalendarDays),
            label: 'Booking',
          ),
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidMessage),
            label: 'Contact',
          ),
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidUser),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Palette.primary,
              child: Text(namePrefix.toUpperCase(), style: const TextStyle(color: Colors.black)),
            ),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}
