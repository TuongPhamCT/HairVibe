import 'package:flutter/src/widgets/framework.dart';
import 'package:hairvibe/Builders/WidgetBuilder/widget_builder.dart';
import 'package:hairvibe/Commands/command_interface.dart';
import 'package:hairvibe/Models/user_model.dart';

import '../../widgets/list_view/barber_list_item.dart';

class BarberListItemBuilder implements CustomizedWidgetBuilder {
  UserModel? barber;
  String? description;
  String? rating;
  CommandInterface? onPressed;

  void setBarber(UserModel barber){
    this.barber = barber;
  }

  void setDescription(String description) {
    this.description = description;
  }

  void setRating(String rating) {
    this.rating = rating;
  }

  void setOnPressed(CommandInterface onPressed) {
    this.onPressed = onPressed;
  }

  @override
  Widget? createWidget() {
    if (barber == null){
      return null;
    }
    return BarberListItem(
      barberName: barber!.name,
      description: description,
      rating: rating,
      onPressed: onPressed,
    );
  }

  @override
  void reset() {
    barber = null;
    description = null;
    rating = null;
    onPressed = null;
  }

}