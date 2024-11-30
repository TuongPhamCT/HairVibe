import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/list_view/review_item.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

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
                '(5)',
                style: TextDecor.nameBarberBook.copyWith(
                  color: Palette.primary,
                ),
              ),
              Expanded(child: Container()),
              InkWell(
                onTap: () {},
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
          Container(
            height: 450,
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ReviewItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}
