import 'package:flutter/material.dart';
import 'package:hairvibe/ChainOfRes/validation/validation_target.dart';
import 'package:hairvibe/Contract/add_barber_screen_contract.dart';
import 'package:hairvibe/Presenter/add_barber_screen_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/admin_contact/contact_list.dart';

import '../../widgets/sign_up_form.dart';
import '../../widgets/util_widgets.dart';

class AddBarberScreen extends StatefulWidget {
  const AddBarberScreen({super.key});

  @override
  State<AddBarberScreen> createState() => _AddBarberScreenState();
}

class _AddBarberScreenState extends State<AddBarberScreen> implements AddBarberScreenContract {
  AddBarberScreenPresenter? _presenter;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  String? emailError;
  String? fullNameError;
  String? phoneError;
  String? passwordError;
  String? confirmPasswordError;

  @override
  void initState() {
    _presenter = AddBarberScreenPresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () {
            onBack();
          },
          child: Text(
            'CANCEL',
            style: TextDecor.leadingForgot.copyWith(color: Palette.primary),
          ),
        ),
        title: Text(
          'ADD BARBER',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              await _presenter?.signUp(
              emailController.text,
              nameController.text,
              phoneController.text,
              passwordController.text,
              confirmPassController.text
              );
            },
            child: Text(
              'SAVE',
              style: TextDecor.leadingForgot.copyWith(color: Palette.primary),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SignUpForm(
              textController: emailController,
              lableText: 'Email',
              obscureText: false,
              keyboardType: TextInputType.text,
              errorText: emailError,
            ),
            SignUpForm(
              textController: nameController,
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
          ],
        ),
      ),
    );
  }

  @override
  void onBack() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AdminContactListPage(tabIndex: 1)),
    );
  }

  @override
  void onSave() {
    UtilWidgets.createDialog(
        context,
        UtilWidgets.NOTIFICATION,
        "Add new barber successfully!",
        () {
          Navigator.of(context, rootNavigator: true).pop();
          onBack();
        }
    );
  }

  @override
  void onValidatingFailed(ValidationTarget errors) {
    setState(() {
      emailError = errors.getErrorText(ValidationUniqueKey.EMAIL);
      fullNameError = errors.getErrorText("name");
      phoneError = errors.getErrorText("phoneNumber");
      passwordError = errors.getErrorText(ValidationUniqueKey.PASSWORD);
      confirmPasswordError = errors.getErrorText(ValidationUniqueKey.REPASSWORD);
    });
  }

  @override
  void onPopContext() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void onWaitingProgressBar() {
    UtilWidgets.createLoadingWidget(context);
  }

  @override
  void onEmailAlreadyInUse() {
    setState(() {
      emailError = "Email has already been taken";
    });
  }

  @override
  void onSignUpFailed() {
    UtilWidgets.createSnackBar(context, "Add barber failed. Please try again.");
  }
}
