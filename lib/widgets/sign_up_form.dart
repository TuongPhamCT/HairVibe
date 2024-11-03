import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';

class SignUpForm extends StatefulWidget {
  final TextEditingController? textController;
  final String lableText;
  bool? obscureText;
  final TextInputType? keyboardType;
  final String? errorText;
  SignUpForm(
      {super.key,
      required this.textController,
      required this.lableText,
      this.obscureText,
      this.keyboardType,
      this.errorText});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late bool isObscure;
  @override
  void initState() {
    super.initState();
    isObscure = widget.obscureText!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      height: 45,
      child: TextField(
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        obscureText: isObscure,
        cursorColor: Palette.primary,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        style: TextDecor.inputText,
        decoration: InputDecoration(
          suffixIcon: widget.obscureText == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                    isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Palette.primary,
                  ),
                )
              : null,
          labelText: widget.lableText,
          labelStyle: TextDecor.hintText,
          floatingLabelStyle: TextDecor.lableText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.primary),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(8),
          ),
          errorText: widget.errorText,
          errorStyle: TextDecor.errorText,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          hintStyle: TextDecor.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
