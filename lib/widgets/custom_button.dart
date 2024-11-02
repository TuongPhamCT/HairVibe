import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';

class CustomButton extends StatefulWidget {
  final Function() onPressed;
  final String text;
  const CustomButton({super.key, required this.onPressed, required this.text});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        height: 45,
        decoration: BoxDecoration(
          color: Palette.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextDecor.buttonText,
          ),
        ),
      ),
    );
  }
}
