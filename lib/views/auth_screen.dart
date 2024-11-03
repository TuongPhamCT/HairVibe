import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/views/sign_in_tab.dart';
import 'package:hairvibe/views/sign_up_tab.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const String routeName = 'auth_page';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Palette.backgroundColor,
                  ],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Image.asset(AssetHelper.backgroundImg),
            Column(
              children: [
                const SizedBox(
                  height: 35,
                ),
                Container(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          AssetHelper.logo,
                          height: 70,
                        ),
                      ),
                      Text(
                        'Hair Vibe',
                        style: TextDecor.title,
                      ),
                    ],
                  ),
                ),
                TabBar(
                  labelColor: Colors.white,
                  indicatorColor: Palette.primary,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelStyle: TextDecor.authTab,
                  tabs: [
                    Tab(text: 'SIGN UP'),
                    Tab(text: 'SIGN IN'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      SignUpTab(),
                      SignInTab(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}