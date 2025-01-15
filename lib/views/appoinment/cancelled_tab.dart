import 'package:flutter/material.dart';
import 'package:hairvibe/Builders/WidgetBuilder/widget_builder_director.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Presenter/appointment_tab_presenter.dart';
import 'package:hairvibe/Theme/text_decor.dart';

import '../../Builders/WidgetBuilder/cancelled_appoint_item_builder.dart';

class CancelledTab extends StatelessWidget {
  final AppointmentTabPresenter presenter;
  final List<AppointmentModel> appointments;

  const CancelledTab({
    super.key,
    required this.presenter,
    required this.appointments
  });

  @override
  Widget build(BuildContext context) {
    CustomizedWidgetBuilderDirector director = CustomizedWidgetBuilderDirector();
    CancelledAppointItemBuilder builder = CancelledAppointItemBuilder();

    Size size = MediaQuery.of(context).size;
    if (appointments.isEmpty) {
      return Center(
        child: Text(
          'You have no cancelled appointments',
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
            director.makeCancelledAppointItem(
                builder: builder,
                appointment: appointments[index],
                presenter: presenter
            );
            return builder.createWidget();
          },
        ),
      );
    }
  }
}
