import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/noti_bell.dart';

class BarberHomeScreen extends StatefulWidget {
  @override
  _BarberHomeScreenState createState() => _BarberHomeScreenState();
}

class _BarberHomeScreenState extends State<BarberHomeScreen> {
  int appointmentCount = 0;

  final int _soLuongThongBao = 2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('HOME', style: TextDecor.homeTitle),
        centerTitle: true,
        actions: [
          NotificationBell(soLuongThongBao: _soLuongThongBao),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildCard(
                      title: 'TODAY SCHEDULE',
                      content: appointmentCount == 0
                          ? 'No appointment.'
                          : '$appointmentCount',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildCard(
                      title: 'COMPLETED APPOINTMENT',
                      content: 'No completed appointments.',
                      lineColor: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildCard(
                      title: 'HOURS BOOKED',
                      content: 'No completed appointments.',
                      lineColor: Palette.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
            label: 'Messages',
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

  Widget _buildCard(
      {required String title, required String content, Color? lineColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Palette.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextDecor.homeTitle.copyWith(color: Colors.white)),
          const SizedBox(height: 8),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(content,
                  style: TextDecor.inter13Medi.copyWith(color: Colors.white)),
            ),
          ),
          if (lineColor != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    7,
                    (index) => Container(
                          width: 20,
                          height: 2,
                          color: lineColor,
                        )),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, int count) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Palette.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(title,
              style: TextDecor.robo16Semi.copyWith(color: Colors.white)),
          const SizedBox(height: 8),
          Text('$count',
              style: TextDecor.inter13Medi.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}
