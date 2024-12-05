import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/appoinment/cancelled_tab.dart';
import 'package:hairvibe/views/appoinment/completed_tab.dart';
import 'package:hairvibe/views/appoinment/upcoming_tab.dart';
import 'package:hairvibe/widgets/bottom_bar.dart';
import 'package:hairvibe/widgets/noti_bell.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});
  static const routeName = 'appointment';

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final int _currentPageIndex = 1;
  final int _soLuongThongBao = 2;
  final int _upcomingCount = 2;
  final int _completedCount = 2;
  final int _cancelledCount = 2;
  final int _testUpcoming = 0;
  final int _testCompleted = 0;
  final int _testCancelled = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'APPOINTMENT',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          NotificationBell(soLuongThongBao: _soLuongThongBao),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            TabBar(
              labelColor: Colors.white,
              indicatorColor: Palette.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelStyle: TextDecor.authTab,
              tabs: const [
                Tab(text: 'UPCOMING'),
                Tab(text: 'COMPLETED'),
                Tab(text: 'CANCELLED'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  UpcomingTab(
                    soLuong: _upcomingCount,
                  ),
                  CompletedTab(
                    soLuong: _completedCount,
                  ),
                  CancelledTab(
                    soLuong: _cancelledCount,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarCustom(
        currentIndex: _currentPageIndex,
      ),
    );
  }
}
