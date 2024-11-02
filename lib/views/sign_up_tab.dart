import 'package:flutter/material.dart';
import 'package:hairvibe/widgets/custom_button.dart';
import 'package:hairvibe/widgets/sign_up_form.dart';

class SignUpTab extends StatefulWidget {
  const SignUpTab({super.key});

  @override
  State<SignUpTab> createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
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
              textController: fullNameController,
              lableText: 'Name',
              obscureText: false,
              keyboardType: TextInputType.text,
              errorText: null,
            ),
            SignUpForm(
              textController: phoneController,
              lableText: 'Phone number',
              obscureText: false,
              keyboardType: TextInputType.number,
              errorText: null,
            ),
            SignUpForm(
              textController: passwordController,
              lableText: 'Password',
              obscureText: true,
              keyboardType: TextInputType.text,
              errorText: null,
            ),
            SignUpForm(
              textController: confirmPassController,
              lableText: 'Confirm Password',
              obscureText: true,
              keyboardType: TextInputType.text,
              errorText: null,
            ),
            Expanded(child: Container()),
            CustomButton(
              onPressed: () {},
              text: 'Sign Up',
            ),
          ],
        ),
      ),
    );
  }
}
