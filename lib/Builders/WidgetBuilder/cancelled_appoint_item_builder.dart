import 'package:flutter/cupertino.dart';
import 'package:hairvibe/Builders/WidgetBuilder/widget_builder.dart';
import 'package:hairvibe/Commands/command_interface.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/widgets/list_view/cancel_appoint_item.dart';

import '../../Models/appointment_model.dart';


class CancelledAppointItemBuilder implements CustomizedWidgetBuilder {
  AppointmentModel? appointment;
  UserModel? barber;
  CommandInterface? onRebookPressed;

  void setAppointment(AppointmentModel appointment) {
    this.appointment = appointment;
  }

  void setBarber(UserModel barber) {
    this.barber = barber;
  }

  void setOnRebookPressed(CommandInterface onPressed) {
    onRebookPressed = onPressed;
  }

  @override
  Widget? createWidget() {
    return CancelledAppointItem(
      date: appointment!.date,
      barberName: barber!.name,
      serviceID: appointment!.appointmentID,
      onRebookPressed: onRebookPressed,
    );
  }

  @override
  void reset() {
    appointment = null;
    barber = null;
    onRebookPressed = null;
  }
}