import 'package:flutter/material.dart';
import 'package:hairvibe/Contract/sign_up_tab_contract.dart';
import 'package:hairvibe/Presenter/sign_up_tab_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/widgets/custom_button.dart';
import 'package:hairvibe/widgets/sign_up_form.dart';

import '../widgets/util_widgets.dart';

class SignUpTab extends StatefulWidget {
  final TabController tabController;

  const SignUpTab({super.key, required this.tabController});

  @override
  State<SignUpTab> createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab> implements SignUpTabContract {
  SignUpTabPresenter? _presenter;
  TabController? _tabController;

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
    _tabController = widget.tabController;
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
                await _presenter?.signUp(
                  emailController.text,
                  fullNameController.text,
                  phoneController.text,
                  passwordController.text,
                  confirmPassController.text
                );
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
    setState(() {
      emailError = "Email has already been taken";
    });
  }

  @override
  void onPopContext() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void onSignUpFailed() {
    UtilWidgets.createDismissibleDialog(
        context,
        UtilWidgets.NOTIFICATION,
        "Sign up failed!",
        () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
  }

  @override
  void onSignUpSucceeded() {
    UtilWidgets.createDialog(
        context,
        UtilWidgets.NOTIFICATION,
        "Sign up successfully!",
        () {
          Navigator.of(context, rootNavigator: true).pop();
          _tabController?.animateTo(1);
        }
    );
  }

  @override
  void onWaitingProgressBar() {
    UtilWidgets.createLoadingWidget(context);
  }

  @override
  void onValidatingFailed(Map<String, String?> errors) {
    if (errors.isNotEmpty){
      setState(() {
        emailError = errors["email"];
        fullNameError = errors["name"];
        phoneError = errors["phoneNumber"];
        passwordError = errors["password"];
        confirmPasswordError = errors["confirmPassword"];
      });
    }
  }
}
