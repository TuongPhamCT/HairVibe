import 'package:flutter/cupertino.dart';
import 'package:hairvibe/Builders/WidgetBuilder/widget_builder.dart';
import 'package:hairvibe/Models/user_model.dart';

import '../../views/all_barber/barber_item_detail.dart';

class BarberItemDetailBuilder implements CustomizedWidgetBuilder {
  UserModel? barber;
  String? description;
  String? rating;
  VoidCallback? onDetailPressed;
  VoidCallback? onBookPressed;

  void setBarber(UserModel barber){
    this.barber = barber;
  }

  void setDescription(String description){
    this.description = description;
  }

  void setRating(String rating){
    this.rating = rating;
  }

  void setOnDetailPressed(VoidCallback onDetailPressed){
    this.onDetailPressed = onDetailPressed;
  }

  void setOnBookPressed(VoidCallback onBookPressed){
    this.onBookPressed = onBookPressed;
  }

  @override
  Widget? createWidget() {
    if (barber == null){
      return null;
    }
    return BarberItemDetail(
        barberName: barber!.name,
        description: description,
        rating: rating,
        onDetailPressed: onDetailPressed,
        onBookPressed: onBookPressed
    );
  }

  @override
  void reset() {
    barber = null;
    rating = null;
    onDetailPressed = null;
    onBookPressed = null;
  }
}