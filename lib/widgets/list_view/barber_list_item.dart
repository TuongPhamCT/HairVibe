import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairvibe/Commands/command_interface.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';

class BarberListItem extends StatefulWidget {
  final String? barberName;
  final String? image;
  final String? description;
  final String? rating;
  final CommandInterface? onPressed;

  const BarberListItem({
    super.key,
    this.barberName,
    this.image,
    this.description,
    this.rating,
    this.onPressed
  });

  @override
  State<BarberListItem> createState() => _BarberListItemState();
}

class _BarberListItemState extends State<BarberListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: Palette.primary.withOpacity(0.2),
      ),
      child:  GestureDetector(
        onTap: () {
          widget.onPressed?.execute();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: widget.image != null && widget.image!.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(widget.image!),
                        fit: BoxFit.cover,
                      )
                    : const DecorationImage(
                        image: AssetImage(AssetHelper.logo),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.barberName ?? "Barber Name",
                  style: TextDecor.serviceListItemTitle,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.description ?? "Description",
                  style: TextDecor.barberListItemKind,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Palette.primary,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.rating ?? "0.0",
                      style: TextDecor.barberListItemKind.copyWith(
                        color: Palette.barberListItemRating,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      )

    );
  }
}
