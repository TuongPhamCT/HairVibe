import 'package:flutter/material.dart';
import 'package:hairvibe/Contract/sign_up_tab_contract.dart';
import 'package:hairvibe/Presenter/sign_up_tab_presenter.dart';
import 'package:hairvibe/widgets/custom_button.dart';
import 'package:hairvibe/widgets/sign_up_form.dart';

class SignUpTab extends StatefulWidget {
  const SignUpTab({super.key});

  @override
  State<SignUpTab> createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab> implements SignUpTabContract {
  SignUpTabPresenter? _presenter;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  String? emailError;
  String? fullNameError;
  String? phoneError;
  String? passwordError;
  String? confirmPasswordError;

  @override
  void initState() {
    _presenter = SignUpTabPresenter(this);
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
              errorText: emailError,
            ),
            SignUpForm(
              textController: fullNameController,
              lableText: 'Name',
              obscureText: false,
              keyboardType: TextInputType.text,
              errorText: fullNameError,
            ),
            SignUpForm(
              textController: phoneController,
              lableText: 'Phone number',
              obscureText: false,
              keyboardType: TextInputType.number,
              errorText: phoneError,
            ),
            SignUpForm(
              textController: passwordController,
              lableText: 'Password',
              obscureText: true,
              keyboardType: TextInputType.text,
              errorText: passwordError,
            ),
            SignUpForm(
              textController: confirmPassController,
              lableText: 'Confirm Password',
              obscureText: true,
              keyboardType: TextInputType.text,
              errorText: confirmPasswordError,
            ),
            Expanded(child: Container()),
            CustomButton(
              onPressed: () async {
                Map<String, String?>? result = await _presenter?.signUp(
                  emailController.text,
                  fullNameController.text,
                  phoneController.text,
                  passwordController.text,
                  confirmPassController.text
                );

                if (result!.isNotEmpty){
                  setState(() {
                    emailError = result["email"];
                    fullNameError = result["name"];
                    phoneError = result["phoneNumber"];
                    passwordError = result["password"];
                    confirmPasswordError = result["confirmPassword"];
                  });
                }

              },
              text: 'SIGN UP',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onEmailAlreadyInUse() {
    emailError = "Email has already been taken";
    setState(() {});
  }

  @override
  void onPopContext() {
    // TODO: implement onPopContext
  }

  @override
  void onSignUpFailed() {

    // TODO: implement onSignUpFailed
  }

  @override
  void onSignUpSucceeded() {
    // TODO: implement onSignUpSucceeded
  }

  @override
  void onWaitingProgressBar() {
    // TODO: implement onWaitingProgressBar
  }
}
