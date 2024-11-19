import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hairvibe/widgets/bottom_bar.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});
  static const routeName = 'appointment';

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int _currentPageIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Appointment Screen'),
      ),
      bottomNavigationBar: BottomBarCustom(
        currentIndex: _currentPageIndex,
      ),
    );
  }
}
