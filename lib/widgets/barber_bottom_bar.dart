import 'package:flutter/material.dart';
import 'package:hairvibe/Singletons/user_singleton.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/views/account/account_page.dart';
import 'package:hairvibe/views/admin/admin_home_screen.dart';
import 'package:hairvibe/views/barber_contact/contact_list.dart';
import 'package:hairvibe/views/barber_details/barber_profile.dart';

import '../views/admin_appointment/appointment_calendar.dart';
// Import necessary pages for navigation

class BarberBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  const BarberBottomNavigationBar({super.key, required this.currentIndex});

  @override
  State<BarberBottomNavigationBar> createState() =>
      _BarberBottomNavigationBarState();
}

class _BarberBottomNavigationBarState extends State<BarberBottomNavigationBar> {
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
      case BarberContactList.routeName:
        return const BarberContactList();
      case BarberProfilePage.routeName:
        return const BarberProfilePage();
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
              _navigateWithoutAnimation(context, BarberContactList.routeName);
              break;
            case 3:
              _navigateWithoutAnimation(context, BarberProfilePage.routeName);
              break;
            case 4:
              _navigateWithoutAnimation(context, AccountPage.routeName);
              break;
          }
        },
        backgroundColor: Colors.black,
        selectedItemColor: Palette.primary,
        unselectedItemColor: Colors.white,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Booking',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: 'Contact',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
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
