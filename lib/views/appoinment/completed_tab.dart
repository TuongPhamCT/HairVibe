import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/list_view/completed_appointment_item.dart';

class CompletedTab extends StatelessWidget {
  final int soLuong;
  const CompletedTab({super.key, required this.soLuong});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (soLuong == 0) {
      return Center(
        child: Text(
          'You have no completed appointments',
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
            return const CompletedAppointItem();
          },
        ),
      );
    }
  }
}
