import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Contract/edit_account_contract.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Presenter/edit_account_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/widgets/bottom_bar.dart';
import 'package:hairvibe/widgets/sign_up_form.dart';
import 'package:hairvibe/widgets/util_widgets.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});
  static const String routeName = 'edit_account_page';

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> implements EditAccountContract {
  EditAccountPresenter? _presenter;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? passwordError;
  String? fullNameError;
  String? phoneError;
  bool isLoading = true;

  @override
  void initState() {
    _presenter = EditAccountPresenter(this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData();
  }

  Future<void> loadData() async {
    await _presenter?.getUserData();
  }

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
            onTap: () {
              _presenter!.updateAccount(
                  fullNameController.text,
                  phoneController.text,
                  passwordController.text
              );
            },
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
      body: isLoading ? const Center( child: CircularProgressIndicator()) : SingleChildScrollView(
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
                enabled: false,
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBarCustom(currentIndex: 3),
    );
  }

  @override
  void onEditFailed() {
    UtilWidgets.createDismissibleDialog(
        context,
        UtilWidgets.NOTIFICATION,
        "Edit failed.",
        () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
  }

  @override
  void onEditSucceeded() {
    UtilWidgets.createDialog(
      context,
      UtilWidgets.NOTIFICATION,
      "Edit successfully!",
      () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context, rootNavigator: true).pop();
      }
    );
  }

  @override
  void onLoadDataSucceed(UserModel model) {
    setState(() {
      emailController.text = model.email!;
      fullNameController.text = model.name!;
      phoneController.text = model.phoneNumber!;
      isLoading = false;
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
  void onValidatingFailed(Map<String, String?> errors) {
    if (errors.isNotEmpty){
      setState(() {
        fullNameError = errors["name"];
        phoneError = errors["phoneNumber"];
        passwordError = errors["password"];
      });
    }
  }
}
