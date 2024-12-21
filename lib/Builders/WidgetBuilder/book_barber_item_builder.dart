import 'package:flutter/src/widgets/framework.dart';
import 'package:hairvibe/Builders/WidgetBuilder/widget_builder.dart';
import 'package:hairvibe/widgets/list_view/book_barber_item.dart';

import '../../Models/user_model.dart';

class BookBarberItemBuilder implements CustomizedWidgetBuilder {
  UserModel? barber;
  String? rating;
  bool isSelected = false;
  VoidCallback? onTap;

  void setBarber(UserModel barber) {
    this.barber = barber;
  }

  void setRating(String rating) {
    this.rating = rating;
  }

  void setIsSelected(bool value) {
    isSelected = value;
  }

  void setOnTap(VoidCallback onTap) {
    this.onTap = onTap;
  }

  @override
  Widget? createWidget() {
    if (barber == null) {
      return null;
    }

    return BookBarberItem(
      title: barber!.name!,
      isSelected: isSelected,
      onTap: onTap ?? () {},
      rating: rating ?? "4.5",
    );
  }

  @override
  void reset() {
    barber = null;
    rating = null;
  }

}