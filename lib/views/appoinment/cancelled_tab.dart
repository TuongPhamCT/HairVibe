import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/text_decor.dart';

class CancelledTab extends StatelessWidget {
  final int soLuong;
  const CancelledTab({super.key, required this.soLuong});

  @override
  Widget build(BuildContext context) {
    if (soLuong == 0) {
      return Center(
        child: Text(
          'You have no cancelled appointments',
          style: TextDecor.robo17Semi,
        ),
      );
    }
    return const Placeholder();
  }
}
