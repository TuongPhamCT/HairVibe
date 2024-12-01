import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/list_view/voucher_item.dart';

class VoucherRedeem extends StatefulWidget {
  const VoucherRedeem({super.key});
  static const String routeName = 'voucher_redeem_page';

  @override
  State<VoucherRedeem> createState() => _VoucherRedeemState();
}

class _VoucherRedeemState extends State<VoucherRedeem> {
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
        child: Column(
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
                  onPressed: () {},
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
              height: size.height * 0.75,
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return const VoucherItem();
                  },
                  itemCount: 5),
            ),
          ],
        ),
      ),
    );
  }
}
