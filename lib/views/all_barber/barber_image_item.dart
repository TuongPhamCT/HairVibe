import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hairvibe/config/asset_helper.dart';

class BarberImageItem extends StatefulWidget {
  const BarberImageItem({super.key});

  @override
  State<BarberImageItem> createState() => _BarberImageItemState();
}

class _BarberImageItemState extends State<BarberImageItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 5,
        ),
        Container(
          height: 72,
          width: 72,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
            image: DecorationImage(
              image: AssetImage(AssetHelper.barberAvatar),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }
}
