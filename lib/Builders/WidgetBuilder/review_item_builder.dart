import 'package:flutter/cupertino.dart';
import 'package:hairvibe/Builders/WidgetBuilder/widget_builder.dart';
import 'package:hairvibe/Models/rating_model.dart';
import 'package:hairvibe/Utility.dart';

import '../../Models/user_model.dart';
import '../../widgets/list_view/review_item.dart';

class ReviewItemBuilder implements CustomizedWidgetBuilder {

  RatingModel? ratingModel;
  UserModel? userModel;

  void setRatingModel(RatingModel model) {
    ratingModel = model;
  }

  void setUserModel(UserModel model) {
    userModel = model;
  }

  @override
  Widget? createWidget() {
    if (ratingModel == null || userModel == null) {
      return null;
    }
    return ReviewItem(
      userName: userModel!.name,
      date: Utility.formatDateFromDateTime(ratingModel!.date),
      rating: ratingModel!.rate?.toDouble(),
      comment: ratingModel!.info,
      avatarUrl: userModel!.image,
    );
  }

  @override
  void reset() {
    ratingModel = null;
    userModel = null;
  }

}