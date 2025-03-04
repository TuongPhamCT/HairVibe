import 'package:flutter/material.dart';
import 'package:hairvibe/Builders/WidgetBuilder/review_item_builder.dart';
import 'package:hairvibe/Models/rating_model.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/Models/user_model.dart';

class BarberReviewTab extends StatelessWidget {
  final List<RatingModel> ratings;
  final Map<String, UserModel> users;

  const BarberReviewTab({
    super.key,
    required this.ratings,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  'Reviews',
                  style: TextDecor.nameBarberBook,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "(${ratings.length})",
                style: TextDecor.nameBarberBook.copyWith(
                  color: Palette.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: ratings.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                ReviewItemBuilder builder = ReviewItemBuilder();
                RatingModel rating = ratings[index];
                builder.setRatingModel(rating);
                builder.setUserModel(users[rating.userID]!);
                return builder.createWidget();
              },
            ),
          ),
        ],
      ),
    );
  }
}
