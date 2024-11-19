import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';

class ServiceListItem extends StatefulWidget {
  const ServiceListItem({super.key});

  @override
  State<ServiceListItem> createState() => _ServiceListItemState();
}

class _ServiceListItemState extends State<ServiceListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.all(9.5),
      decoration: BoxDecoration(
        color: Palette.primary.withOpacity(0.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Buzz cut',
                style: TextDecor.serviceListItemTitle,
              ),
              Text(
                '30 minutes',
                style: TextDecor.serviceListItemTime,
              ),
            ],
          ),
          Text(
            '10.000 VNĐ',
            style: TextDecor.serviceListItemTitle,
          ),
        ],
      ),
    );
  }
}
