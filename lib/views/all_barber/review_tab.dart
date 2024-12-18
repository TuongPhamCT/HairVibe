import 'package:flutter/material.dart';
import 'package:hairvibe/Builders/WidgetBuilder/review_item_builder.dart';
import 'package:hairvibe/Models/rating_model.dart';
import 'package:hairvibe/Presenter/detail_barber_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/all_barber/rating_barber.dart';
import 'package:hairvibe/widgets/list_view/review_item.dart';

class ReviewsTab extends StatelessWidget {
  final DetailBarberPresenter presenter;
  const ReviewsTab({
    super.key,
    required this.presenter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Reviews',
                style: TextDecor.nameBarberBook,
              ),
              const SizedBox(width: 10),
              Text(
                "(${presenter.ratings.length})",
                style: TextDecor.nameBarberBook.copyWith(
                  color: Palette.primary,
                ),
              ),
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RatingBarberPage.routeName);
                },
                child: Text(
                  'Add Review',
                  style: TextDecor.nameBarberBook.copyWith(
                    color: Palette.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 450,
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                ReviewItemBuilder builder = ReviewItemBuilder();
                RatingModel rating = presenter.ratings[index];
                builder.setRatingModel(rating);
                builder.setUserModel(presenter.users[rating.userID]!);
                return builder.createWidget();
              },
            ),
          ),
        ],
      ),
    );
  }
}
