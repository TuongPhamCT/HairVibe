import 'package:flutter/material.dart';
import 'package:hairvibe/Builders/WidgetBuilder/upcoming_appoint_item_builder.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/list_view/upcoming_appointment_item.dart';

import '../../Models/appointment_model.dart';
import '../../Presenter/appointment_tab_presenter.dart';

class UpcomingTab extends StatelessWidget {
  final AppointmentTabPresenter presenter;
  final List<AppointmentModel> appointments;

  const UpcomingTab({
    super.key,
    required this.presenter,
    required this.appointments
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (appointments.isEmpty) {
      return Center(
        child: Text(
          'You have no upcoming appointments',
          style: TextDecor.robo17Semi,
        ),
      );
    } else {
      return Container(
        width: size.width,
        height: double.infinity,
        padding: const EdgeInsets.all(30),
        child: ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            UpcomingAppointItemBuilder builder = UpcomingAppointItemBuilder();
            builder.setAppointment(appointments[index]);
            builder.setBarber(presenter.findBarberByID(appointments[index].barberID!)!);
            builder.setOnCancelPressed(() {
              presenter.handleCancelPressed(appointments[index]);
            });
            builder.setOnViewReceiptPressed(() {
              presenter.handleViewReceiptPressed(appointments[index]);
            });
            return builder.createWidget();
          },
        ),
      );
    }
  }
}
