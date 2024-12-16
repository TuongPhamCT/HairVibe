import 'package:flutter/cupertino.dart';
import 'package:hairvibe/Builders/WidgetBuilder/widget_builder.dart';
import 'package:hairvibe/widgets/list_view/upcoming_appointment_item.dart';
import '../../Models/appointment_model.dart';
import '../../Models/user_model.dart';


class UpcomingAppointItemBuilder implements CustomizedWidgetBuilder {
  AppointmentModel? appointment;
  UserModel? barber;
  VoidCallback? onCancelPressed;
  VoidCallback? onViewReceiptPressed;

  void setAppointment(AppointmentModel appointment) {
    this.appointment = appointment;
  }

  void setBarber(UserModel barber) {
    this.barber = barber;
  }

  void setOnCancelPressed(VoidCallback onPressed) {
    onCancelPressed = onPressed;
  }

  void setOnViewReceiptPressed(VoidCallback onPressed) {
    onViewReceiptPressed = onPressed;
  }

  @override
  Widget? createWidget() {
    return UpcomingAppointItem(
      date: appointment!.date,
      barberName: barber!.name,
      serviceID: appointment!.appointmentID,
      onCancelPressed: onCancelPressed,
      onViewReceiptPressed: onViewReceiptPressed,
    );
  }

  @override
  void reset() {
    appointment = null;
    barber = null;
    onCancelPressed = null;
    onViewReceiptPressed = null;
  }
}