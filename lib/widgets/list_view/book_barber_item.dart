import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';

class BookBarberItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const BookBarberItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Palette.primary : Colors.transparent,
            width: 2.5,
          ),
          color: Palette.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(AssetHelper.barberAvatar),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            Text(
              title,
              style: TextDecor.nameBarberBook,
            ),
            const SizedBox(
              height: 5,
            ),
            Text('MS001', style: TextDecor.idBarber),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.yellowAccent,
                  size: 20,
                ),
                Text(
                  '4.5',
                  style: TextDecor.searchHintText.copyWith(
                    color: Colors.white,
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
