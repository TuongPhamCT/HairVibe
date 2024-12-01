import 'package:flutter/material.dart';

class AppointmentButton extends StatelessWidget {
  final double width;
  final Color? backgroundColor;
  final BorderSide borderSide;
  final Widget? child;
  final Function()? onPressed;
  const AppointmentButton(
      {super.key,
      this.width = 150,
      this.backgroundColor,
      this.borderSide = BorderSide.none,
      this.child,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
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
