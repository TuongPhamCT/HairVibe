import 'package:flutter/material.dart';
import 'package:hairvibe/Presenter/detail_barber_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/barber_details/barber_schedule_list.dart';

class BarberInfoTab extends StatelessWidget {
  final DetailBarberPresenter presenter;
  final List<Map<String, String>> workingHours;
  const BarberInfoTab({
    super.key,
    required this.presenter,
    required this.workingHours,
  });

  @override
  Widget build(BuildContext context) {
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
                        builder: (context) => ScheduleListScreen(presenter: presenter),
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
