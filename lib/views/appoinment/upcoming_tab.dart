import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/list_view/upcoming_appointment_item.dart';

class UpcomingTab extends StatelessWidget {
  final int soLuong;
  const UpcomingTab({super.key, required this.soLuong});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (soLuong == 0) {
      return Center(
        child: Text(
          'You have no upcoming appointments',
          style: TextDecor.robo17Semi,
        ),
      );
    } else {
      return Container(
        width: size.width,
        height: double.infinity,
        padding: const EdgeInsets.all(30),
        child: ListView.builder(
          itemCount: soLuong,
          itemBuilder: (context, index) {
            return const UpcomingAppointmentItem();
          },
        ),
      );
    }
  }
}
