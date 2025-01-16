import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/views/account/account_page.dart';
import 'package:hairvibe/views/appoinment/appointment.dart';
import 'package:hairvibe/views/home/home_screen.dart';
import 'package:hairvibe/views/voucher/voucher_page.dart';

class BottomBarCustom extends StatefulWidget {
  final int currentIndex;
  const BottomBarCustom({super.key, required this.currentIndex});

  @override
  State<BottomBarCustom> createState() => _BottomBarCustomState();
}

class _BottomBarCustomState extends State<BottomBarCustom> {
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
          if (value == 0) {
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          } else if (value == 1) {
            Navigator.of(context).pushNamed(AppointmentScreen.routeName);
          } else if (value == 2) {
            Navigator.of(context).pushNamed(VoucherPage.routeName);
          } else {
            Navigator.of(context).pushNamed(AccountPage.routeName);
          }
        },
        backgroundColor: Colors.black,
        selectedItemColor: Palette.primary,
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.houseChimney),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidCalendarDays),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.ticket),
            label: 'Voucher',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidUser),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
