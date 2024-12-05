import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';

class CheckServiceListItem extends StatelessWidget {
  final String title;
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const CheckServiceListItem({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!isChecked);
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
                      '30 minutes',
                      style: TextDecor.serviceListItemTime,
                    ),
                  ],
                ),
              ],
            ),
            Text(
              '10.000 VNĐ',
              style: TextDecor.serviceListItemTitle,
            ),
          ],
        ),
      ),
    );
  }
}
