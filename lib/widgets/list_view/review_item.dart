import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';

class ReviewItem extends StatelessWidget {
  final String? userName;
  final String? date;
  final double? rating;
  final String? comment;
  final String? avatarUrl;

  const ReviewItem(
      {super.key,
      required this.userName,
      required this.date,
      required this.rating,
      required this.comment,
      required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Palette.primary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: avatarUrl != null && avatarUrl!.isNotEmpty
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(avatarUrl!),
                          fit: BoxFit.cover,
                        ),
                      )
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage(AssetHelper.logo),
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName ?? "User",
                    style: TextDecor.homeTitle,
                  ),
                  Row(
                    children: [
                      Text(
                        date ?? "dd/MM/yyyy",
                        style: TextDecor.robo13SemiHint,
                      ),
                      const SizedBox(width: 10),
                      RatingBar.builder(
                        initialRating: rating ?? 5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 18,
                        unratedColor: const Color(0xffDADADA),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (value) {},
                        ignoreGestures: true,
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(child: Container()),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            comment ?? "comment",
            style: TextDecor.inter14,
          ),
        ],
      ),
    );
  }
}
