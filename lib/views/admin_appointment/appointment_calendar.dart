import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/noti_bell.dart';
import 'package:hairvibe/widgets/admin_bottom_bar.dart';

class AdminAppointmentPage extends StatefulWidget {
  const AdminAppointmentPage({super.key});
  static const routeName = 'admin_appointment';
  @override
  _AdminAppointmentPageState createState() => _AdminAppointmentPageState();
}

class _AdminAppointmentPageState extends State<AdminAppointmentPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<String> _appointments = []; // No appointments initially
  final int _currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          'APPOINTMENT',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          NotificationBell(soLuongThongBao: 3),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: TextStyle(color: Colors.white),
                  weekendTextStyle: TextStyle(color: Colors.white),
                ),
                headerStyle: HeaderStyle(
                  titleTextStyle: TextDecor.titleCalendar,
                  formatButtonVisible: false,
                  leftChevronIcon: Icon(Icons.arrow_back, color: Colors.white),
                  rightChevronIcon:
                      Icon(Icons.arrow_forward, color: Colors.white),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.white),
                  weekendStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            // if (_appointments.isNotEmpty)
            //   Container(
            //     margin: const EdgeInsets.all(16),
            //     padding: const EdgeInsets.all(16),
            //     decoration: BoxDecoration(
            //       color: Colors.grey[800],
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: _appointments.map((appointment) {
            //         return Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text('12pm', style: TextStyle(color: Colors.white)),
            //             SizedBox(height: 8),
            //             Container(
            //               height: 50,
            //               color: Colors.blue,
            //               child: Center(
            //                 child: Text(
            //                   appointment,
            //                   style: TextStyle(color: Colors.white),
            //                 ),
            //               ),
            //             ),
            //             SizedBox(height: 8),
            //           ],
            //         );
            //       }).toList(),
            //     ),
            //   ),
          ],
        ),
      ),
      bottomNavigationBar: AdminBottomBar(currentIndex: _currentPageIndex),
    );
  }
}
