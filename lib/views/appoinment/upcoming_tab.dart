import 'package:flutter/material.dart';
import 'package:hairvibe/Builders/WidgetBuilder/upcoming_appoint_item_builder.dart';
import 'package:hairvibe/Theme/text_decor.dart';

import '../../Builders/WidgetBuilder/widget_builder_director.dart';
import '../../Models/appointment_model.dart';
import '../../Presenter/appointment_tab_presenter.dart';

class UpcomingTab extends StatelessWidget {
  final AppointmentTabPresenter presenter;
  final List<AppointmentModel> appointments;

  const UpcomingTab(
      {super.key, required this.presenter, required this.appointments});

  @override
  Widget build(BuildContext context) {
    CustomizedWidgetBuilderDirector director =
        CustomizedWidgetBuilderDirector();
    UpcomingAppointItemBuilder builder = UpcomingAppointItemBuilder();
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
            director.makeUpcomingAppointItem(
                builder: builder,
                appointment: appointments[index],
                presenter: presenter);
            return builder.createWidget();
          },
        ),
      );
    }
  }
}
