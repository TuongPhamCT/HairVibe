import 'package:flutter/material.dart';
import 'package:hairvibe/Contract/sign_in_tab_contract.dart';
import 'package:hairvibe/Presenter/sign_in_tab_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/forgot_pass_screen.dart';
import 'package:hairvibe/views/home/home_screen.dart';
import 'package:hairvibe/widgets/custom_button.dart';
import 'package:hairvibe/widgets/sign_up_form.dart';

class SignInTab extends StatefulWidget {
  const SignInTab({super.key});

  @override
  State<SignInTab> createState() => _SignInTabState();
}

class _SignInTabState extends State<SignInTab> implements SignInTabContract {
  SignInTabPresenter? _presenter;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorText = "";

  @override
  void initState() {
    _presenter = SignInTabPresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height * 0.77,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SignUpForm(
              textController: emailController,
              lableText: 'Email',
              obscureText: false,
              keyboardType: TextInputType.text,
              errorText: null,
            ),
            SignUpForm(
              textController: passwordController,
              lableText: 'Password',
              obscureText: true,
              keyboardType: TextInputType.text,
              errorText: errorText != "" ? errorText : null,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(ForgotPassScreen.routeName);
                },
                child: Text(
                  'FORGOT PASSWORD?',
                  style: TextDecor.buttonText.copyWith(
                    color: Palette.primary,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            CustomButton(
              onPressed: () {
                _presenter!
                    .login(emailController.text, passwordController.text);
              },
              text: 'LOG IN',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onLoginFailed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Palette.primary,
        content: Text(
          'Cannot Sign up! Please try again later!',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
    errorText = "Email or password is invalid";
  }

  @override
  void onLoginSucceeded() {
    // TODO: implement onLoginSucceeded
    errorText = "";
    Navigator.of(context).pushNamed(HomeScreen.routeName);
  }

  @override
  void onPopContext() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void onWaitingProgressBar() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
  }
}
