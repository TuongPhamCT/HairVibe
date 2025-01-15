import 'package:flutter/material.dart';
import 'package:hairvibe/Contract/voucher_page_contract.dart';
import 'package:hairvibe/Models/coupon_model.dart';
import 'package:hairvibe/Presenter/voucher_page_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/booking/main_booking.dart';
import 'package:hairvibe/views/voucher/redeem_voucher.dart';
import 'package:hairvibe/widgets/bottom_bar.dart';
import 'package:hairvibe/widgets/list_view/voucher_item.dart';

import '../../Builders/WidgetBuilder/voucher_item_builder.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});
  static const routeName = 'voucher_page';

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> implements VoucherPageContract {
  VoucherPagePresenter? _presenter;

  List<CouponModel> coupons = [];

  final int _currentPageIndex = 2;

  bool isLoading = true;

  @override
  void initState() {
    _presenter = VoucherPagePresenter(this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData();
  }

  Future<void> loadData() async {
    await _presenter?.getData();
  }

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
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       Navigator.of(context).pushNamed(RedeemVoucher.routeName);
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.only(right: 20),
        //       child: Text(
        //         'Redeem code',
        //         style:
        //             TextDecor.robo13SemiHint.copyWith(color: Palette.primary),
        //       ),
        //     ),
        //   ),
        // ],
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
              height: size.height * 0.70,
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    VoucherItemBuilder builder = VoucherItemBuilder();
                    builder.setCouponModel(coupons[index]);
                    builder.setOnPressed(() {
                      _presenter?.handleUseVoucher(coupons[index]);
                    });
                    return builder.createWidget();
                  },
                  itemCount: coupons.length,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarCustom(
        currentIndex: _currentPageIndex,
      ),
    );
  }

  @override
  void onLoadDataSucceed() {
    setState(() {
      coupons = _presenter!.coupons;
      isLoading = false;
    });
  }

  @override
  void onUseVoucher() {
    Navigator.of(context).pushNamed(MainBooking.routeName);
  }
}
