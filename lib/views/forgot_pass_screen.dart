import 'package:flutter/material.dart';
import 'package:hairvibe/Contract/forgot_pass_contract.dart';
import 'package:hairvibe/Presenter/forgot_pass_presenter.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/reset_password_screen.dart';
import 'package:hairvibe/widgets/sign_up_form.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  static const String routeName = 'forgot_pass_screen';

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> implements ForgotPassScreenContract {
  ForgotPassScreenPresenter? _presenter;

  TextEditingController emailController = TextEditingController();
  String? emailError;

  @override
  void initState() {
    _presenter = ForgotPassScreenPresenter(this);
    super.initState();
  }

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
              onTap: () {
                _presenter?.resetPassword(emailController.text);
              },
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
            textController: emailController,
            lableText: 'Email',
            obscureText: false,
            keyboardType: TextInputType.text,
            errorText: emailError,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Please enter the email associated with your account. We will email you a link to reset your password',
              style: TextDecor.roboMedium13,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onEmailNotFound() {
    emailError = "This email doesn't exist";
  }

  @override
  void onPopContext() {
    // TODO: implement onPopContext
  }

  @override
  void onResetFailed() {
    // TODO: implement onResetFailed
  }

  @override
  void onResetSucceeded() {
    // TODO: implement onResetSucceeded
  }

  @override
  void onWaitingProgressBar() {
    // TODO: implement onWaitingProgressBar
  }
}
