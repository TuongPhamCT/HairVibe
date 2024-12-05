import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/voucher/redeem_voucher.dart';
import 'package:hairvibe/widgets/bottom_bar.dart';
import 'package:hairvibe/widgets/list_view/voucher_item.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});
  static const routeName = 'voucher_page';

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  int _currentPageIndex = 2;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'VOUCHER',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(RedeemVoucher.routeName);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                'Redeem code',
                style:
                    TextDecor.robo13SemiHint.copyWith(color: Palette.primary),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '#Specials for you',
              style: TextDecor.homeTitle,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: size.height * 0.735,
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return const VoucherItem();
                  },
                  itemCount: 5),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarCustom(
        currentIndex: _currentPageIndex,
      ),
    );
  }
}
