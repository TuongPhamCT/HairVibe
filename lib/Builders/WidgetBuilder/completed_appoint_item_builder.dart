import 'package:flutter/cupertino.dart';
import 'package:hairvibe/Builders/WidgetBuilder/widget_builder.dart';
import 'package:hairvibe/widgets/list_view/completed_appointment_item.dart';

import '../../Models/appointment_model.dart';
import '../../Models/user_model.dart';


class CompletedAppointItemBuilder implements CustomizedWidgetBuilder {
  AppointmentModel? appointment;
  UserModel? barber;
  VoidCallback? onViewReceiptPressed;

  void setAppointment(AppointmentModel appointment) {
    this.appointment = appointment;
  }

  void setBarber(UserModel barber) {
    this.barber = barber;
  }

  void setOnViewReceiptPressed(VoidCallback onPressed) {
    onViewReceiptPressed = onPressed;
  }

  @override
  Widget? createWidget() {
    return CompletedAppointItem(
      date: appointment!.date,
      barberName: barber!.name,
      serviceID: appointment!.appointmentID,
      onViewReceiptPressed: onViewReceiptPressed,
    );
  }

  @override
  void reset() {
    appointment = null;
    barber = null;
    onViewReceiptPressed = null;
  }
}