import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';

class ServiceListItem extends StatefulWidget {
  String? serviceName;
  String? duration;
  String? cost;

  ServiceListItem({
    super.key,
    this.serviceName,
    this.duration,
    this.cost
  });

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
                widget.serviceName ?? "",
                style: TextDecor.serviceListItemTitle,
              ),
              Text(
                widget.duration ?? "-:-",
                style: TextDecor.serviceListItemTime,
              ),
            ],
          ),
          Text(
            widget.cost ?? "XX,000 VNĐ",
            style: TextDecor.serviceListItemTitle,
          ),
        ],
      ),
    );
  }
}
