import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/views/barber/home_screen.dart';
import 'package:hairvibe/views/admin_appointment/appointment_calendar.dart';
import 'package:hairvibe/views/admin/home_screen.dart';
import 'package:hairvibe/views/admin_contact/contact_list.dart';
import 'package:hairvibe/views/admin_management/comment.dart';
import 'package:hairvibe/views/barber_contact/contact_list.dart';
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
      case BarberHomeScreen.routeName:
        return BarberHomeScreen();
      case AdminAppointmentPage.routeName:
        return AdminAppointmentPage();
      case BarberContactList.routeName:
        return BarberContactList();
      case AdminCommentPage.routeName:
        return AdminCommentPage();
      default:
        return AdminHomeScreen(); // Default page
    }
  }

  @override
  Widget build(BuildContext context) {
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
              _navigateWithoutAnimation(context, BarberHomeScreen.routeName);
              break;
            case 1:
              _navigateWithoutAnimation(
                  context, AdminAppointmentPage.routeName);
              break;
            case 2:
              _navigateWithoutAnimation(context, BarberContactList.routeName);
              break;
            case 3:
              _navigateWithoutAnimation(context, AdminCommentPage.routeName);
              break;
            case 4:
              // Add logic for the fifth item if needed
              break;
          }
        },
        backgroundColor: Colors.black,
        selectedItemColor: Palette.primary,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Palette.primary,
              child: Text('D', style: TextStyle(color: Colors.black)),
            ),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}
