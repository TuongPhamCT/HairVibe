import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';

class VoucherItem extends StatelessWidget {
  const VoucherItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Palette.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Voucher Name',
                style: TextDecor.homeTitle.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 5),
              Text(
                'Voucher Code',
                style: TextDecor.searchText,
              ),
              const SizedBox(height: 5),
              Text(
                'Discount: 10%',
                style: TextDecor.inter16Bold.copyWith(color: Colors.green),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Palette.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Use',
              style: TextDecor.authTab,
            ),
          ),
        ],
      ),
    );
  }
}
