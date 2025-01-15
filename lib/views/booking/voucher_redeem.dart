import 'package:flutter/material.dart';
import 'package:hairvibe/Builders/WidgetBuilder/voucher_item_builder.dart';
import 'package:hairvibe/Contract/voucher_redeem_contract.dart';
import 'package:hairvibe/Models/coupon_model.dart';
import 'package:hairvibe/Presenter/voucher_redeem_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/util_widgets.dart';

class VoucherRedeem extends StatefulWidget {
  const VoucherRedeem({super.key});
  static const String routeName = 'voucher_redeem_page';

  @override
  State<VoucherRedeem> createState() => _VoucherRedeemState();
}

class _VoucherRedeemState extends State<VoucherRedeem> implements VoucherRedeemContract {
  VoucherRedeemPresenter? _presenter;
  final TextEditingController redeemController = TextEditingController();

  List<CouponModel> coupons = [];
  bool isLoading = true;

  @override
  void initState() {
    _presenter = VoucherRedeemPresenter(this);
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
        leadingWidth: 0,
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel', style: TextDecor.leadingForgot),
              ),
            ),
            Text('Voucher', style: TextDecor.homeTitle),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: isLoading ? UtilWidgets.getLoadingWidget() : Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.65,
                  decoration: BoxDecoration(
                    color: Palette.primary.withOpacity(0.2),
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    controller: redeemController,
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
                ElevatedButton(
                  onPressed: () {
                    _presenter?.handleRedeemCode(redeemController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.voucherHint,
                    fixedSize: const Size(85, 53),
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Apply', style: TextDecor.robo15Semi),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: size.height * 0.6,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  VoucherItemBuilder builder = VoucherItemBuilder();
                  builder.setCouponModel(coupons[index]);
                  builder.setOnPressed(() {
                    _presenter?.handleUseVoucher(coupons[index]);
                  });
                  return builder.createWidget();
                },
                itemCount: coupons.length
              ),
            ),
          ],
        ),
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
    Navigator.of(context).pop();
  }

  @override
  void onRedeemFailed(String message) {
    UtilWidgets.createSnackBar(context, message);
  }

  @override
  void onRedeemSucceed() {
    Navigator.of(context).pop();
  }
}
