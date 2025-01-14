import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/commands/command_interface.dart';

class ServiceListItem extends StatefulWidget {
  final String? serviceName;
  final String? duration;
  final String? cost;
  final CommandInterface? onPressed;
  final bool? deletable;
  final CommandInterface? onDelete;

  const ServiceListItem({
    super.key,
    this.serviceName,
    this.duration,
    this.cost,
    this.onPressed,
    this.deletable,
    this.onDelete
  });

  @override
  State<ServiceListItem> createState() => _ServiceListItemState();
}

class _ServiceListItemState extends State<ServiceListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed?.execute();
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
            if (widget.deletable == true)
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  await showAskDeleteDialog();
                },
                icon: const Icon(
                  FontAwesomeIcons.deleteLeft,
                  color: Palette.primary,
                  size: 27,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> showAskDeleteDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text(
              'Are you sure you want to delete this service?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onDelete?.execute();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
