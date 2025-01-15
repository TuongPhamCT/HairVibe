import 'package:flutter/cupertino.dart';
import 'package:hairvibe/Builders/WidgetBuilder/widget_builder.dart';
import 'package:hairvibe/Commands/command_interface.dart';
import 'package:hairvibe/Models/user_model.dart';

import '../../views/all_barber/barber_item_detail.dart';

class BarberItemDetailBuilder implements CustomizedWidgetBuilder {
  UserModel? barber;
  String? description;
  String? rating;
  List<int>? workSessions;
  CommandInterface? onDetailPressed;
  CommandInterface? onBookPressed;

  void setBarber(UserModel barber){
    this.barber = barber;
  }

  void setDescription(String description){
    this.description = description;
  }

  void setRating(String rating){
    this.rating = rating;
  }

  void setWorkSessions(List<int> workSessions) {
    this.workSessions = workSessions;
  }

  void setOnDetailPressed(CommandInterface onDetailPressed){
    this.onDetailPressed = onDetailPressed;
  }

  void setOnBookPressed(CommandInterface onBookPressed){
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
        workSessions: workSessions,
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
    workSessions = null;
  }
}