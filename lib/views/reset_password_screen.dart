import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/custom_button.dart';
import 'package:hairvibe/widgets/sign_up_form.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  static const String routeName = 'reset_password_screen';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  BuildContext? progressbarContext;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: 0,
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text('CANCEL', style: TextDecor.leadingForgot),
            ),
            Text('FORGOT PASSWORD', style: TextDecor.forgotTitle),
            InkWell(
              onTap: () {},
              child: Text('RESET', style: TextDecor.leadingForgot),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          SignUpForm(
            textController: newPasswordController,
            lableText: 'New Password',
            obscureText: true,
            keyboardType: TextInputType.text,
            errorText: null,
          ),
          SignUpForm(
            textController: confirmPasswordController,
            lableText: 'Confirm Password',
            obscureText: true,
            keyboardType: TextInputType.text,
            errorText: null,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(onPressed: () {}, text: "RESET"),
        ],
      ),
    );
  }

  @override
  void onWaitingProgressBar() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          progressbarContext = context;
          return const Center(child: CircularProgressIndicator());
        });
  }

  @override
  void onPopContext() {
    Navigator.of(progressbarContext??context).pop();
  }
}
