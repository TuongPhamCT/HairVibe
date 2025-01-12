import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/barber_details/barber_schedule_list.dart';

class BarberInfoTab extends StatelessWidget {
  const BarberInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> workingHours = [
      {'day': 'Monday', 'hours': '9am - 6pm'},
      {'day': 'Tuesday', 'hours': '9am - 6pm'},
      {'day': 'Wednesday', 'hours': '9am - 6pm'},
      {'day': 'Thursday', 'hours': '9am - 6pm'},
      {'day': 'Friday', 'hours': '9am - 6pm'},
      {'day': 'Saturday', 'hours': '9am - 6pm'},
      {'day': 'Sunday', 'hours': 'Closed'},
    ];

    final double horizontalPadding = MediaQuery.of(context).size.width * 0.05;
    final double verticalPadding = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: verticalPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Working hour',
                  style: TextDecor.homeTitle,
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to BarberScheduleList page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleListScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Edit',
                    style: TextDecor.homeTitle.copyWith(color: Colors.amber),
                  ),
                ),
              ],
            ),
            SizedBox(height: verticalPadding),
            Expanded(
              child: ListView.builder(
                itemCount: workingHours.length,
                itemBuilder: (context, index) {
                  final day = workingHours[index]['day']!;
                  final hours = workingHours[index]['hours']!;
                  return Container(
                    color: Colors.grey[850],
                    padding: EdgeInsets.symmetric(
                        vertical: verticalPadding,
                        horizontal: horizontalPadding),
                    margin: EdgeInsets.only(bottom: verticalPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          day,
                          style: TextDecor.serviceListItemTitle,
                        ),
                        Text(
                          hours,
                          style: TextDecor.serviceListItemTitle,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
