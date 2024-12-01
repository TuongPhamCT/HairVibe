import 'package:flutter/material.dart';
import 'package:hairvibe/widgets/bottom_bar.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  static const routeName = 'account_page';

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _currentPageIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarCustom(
        currentIndex: _currentPageIndex,
      ),
    );
  }
}
