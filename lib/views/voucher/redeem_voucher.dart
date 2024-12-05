import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/bottom_bar.dart';

class RedeemVoucher extends StatelessWidget {
  const RedeemVoucher({super.key});
  static const String routeName = 'redeem_voucher_page';

  @override
  Widget build(BuildContext context) {
    int _currentPageIndex = 2;
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
          'VOUCHER',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                'Redeem',
                style:
                    TextDecor.robo13SemiHint.copyWith(color: Palette.primary),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          color: Palette.primary.withOpacity(0.2),
          // color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          style: TextDecor.inputText,
          decoration: InputDecoration(
            hintText: 'Enter Voucher Code',
            hintStyle: TextDecor.robo13SemiHint,
            contentPadding: const EdgeInsets.all(14),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBarCustom(
        currentIndex: _currentPageIndex,
      ),
    );
  }
}
