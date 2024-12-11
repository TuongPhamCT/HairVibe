import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';

class BarberListItem extends StatefulWidget {
  String? barberName;
  String? description;
  String? rating;

  BarberListItem({
    super.key,
    this.barberName,
    this.description,
    this.rating
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetHelper.barberAvatar),
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
    );
  }
}
