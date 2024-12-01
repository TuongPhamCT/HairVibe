import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/widgets/bottom_bar.dart';
import 'package:hairvibe/widgets/sign_up_form.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});
  static const String routeName = 'edit_account_page';

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Palette.primary,
          ),
        ),
        backgroundColor: Colors.black,
        title: Text(
          'MANAGE ACCOUNT',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                'Save',
                style:
                    TextDecor.robo13SemiHint.copyWith(color: Palette.primary),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width,
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(AssetHelper.barberAvatar),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'EDIT PROFILE PICTURE',
                  style: TextDecor.robo14Bold,
                ),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBarCustom(currentIndex: 3),
    );
  }
}
