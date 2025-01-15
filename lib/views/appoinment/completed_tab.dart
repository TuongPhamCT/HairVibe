import 'package:flutter/material.dart';
import 'package:hairvibe/Builders/WidgetBuilder/completed_appoint_item_builder.dart';
import 'package:hairvibe/Builders/WidgetBuilder/widget_builder_director.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Presenter/appointment_tab_presenter.dart';
import 'package:hairvibe/Theme/text_decor.dart';

class CompletedTab extends StatelessWidget {
  final AppointmentTabPresenter presenter;
  final List<AppointmentModel> appointments;

  const CompletedTab({
    super.key,
    required this.presenter,
    required this.appointments
  });

  @override
  Widget build(BuildContext context) {
    CustomizedWidgetBuilderDirector director = CustomizedWidgetBuilderDirector();
    CompletedAppointItemBuilder builder = CompletedAppointItemBuilder();

    Size size = MediaQuery.of(context).size;
    if (appointments.isEmpty) {
      return Center(
        child: Text(
          'You have no completed appointments',
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
            director.makeCompletedAppointItem(
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
