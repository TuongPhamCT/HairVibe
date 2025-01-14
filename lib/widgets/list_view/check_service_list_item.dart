import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';

class CheckServiceListItem extends StatelessWidget {
  final String title;
  bool? isChecked;
  final String duration;
  final String price;
  final ValueChanged<bool> onChanged;

  CheckServiceListItem({
    super.key,
    required this.title,
    this.isChecked,
    required this.duration,
    required this.price,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!isChecked!);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 4),
        padding: const EdgeInsets.all(9.5),
        decoration: BoxDecoration(
          color: Palette.primary.withOpacity(0.2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Palette.primary,
                  shape: const CircleBorder(),
                  side: const BorderSide(color: Palette.primary),
                  value: isChecked,
                  onChanged: (value) {
                    onChanged(value!);
                    isChecked = value;
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextDecor.serviceListItemTitle,
                    ),
                    Text(
                      duration,
                      style: TextDecor.serviceListItemTime,
                    ),
                  ],
                ),
              ],
            ),
            Text(
              price,
              style: TextDecor.serviceListItemTitle,
            ),
          ],
        ),
      ),
    );
  }
}
