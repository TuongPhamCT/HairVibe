import 'package:flutter/material.dart';

class AppointmentButton extends StatelessWidget {
  final double width;
  final Color? backgroundColor;
  final BorderSide borderSide;
  final Widget? child;
  const AppointmentButton(
      {super.key,
      this.width = 150,
      this.backgroundColor,
      this.borderSide = BorderSide.none, this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: child,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: borderSide,
        ),
        fixedSize: Size(width, 40),
        backgroundColor: backgroundColor,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
