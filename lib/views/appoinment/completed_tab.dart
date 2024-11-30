import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/text_decor.dart';

class CompletedTab extends StatelessWidget {
  final int soLuong;
  const CompletedTab({super.key, required this.soLuong});

  @override
  Widget build(BuildContext context) {
    if (soLuong == 0) {
      return Center(
        child: Text(
          'You have no completed appointments',
          style: TextDecor.robo17Semi,
        ),
      );
    }
    return const Placeholder();
  }
}
