import 'package:flutter/material.dart';
import 'package:hairvibe/Presenter/detail_barber_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/util_widgets.dart';

import '../../Contract/schedule_list_screen_contract.dart';
import '../../Presenter/schedule_list_screen_presenter.dart';

class ScheduleListScreen extends StatefulWidget {
  final DetailBarberPresenter presenter;
  const ScheduleListScreen({
    super.key,
    required this.presenter
  });

  @override
  ScheduleListScreenState createState() => ScheduleListScreenState();
}

class ScheduleListScreenState extends State<ScheduleListScreen> implements ScheduleListScreenContract {
  ScheduleListScreenPresenter? _presenter;

  final List<Map<String, dynamic>> workingHours = [
    {'day': 'Monday', 'enabled': true, 'time': '8am - 6pm'},
    {'day': 'Tuesday', 'enabled': true, 'time': '9am - 6pm'},
    {'day': 'Wednesday', 'enabled': true, 'time': '9am - 6pm'},
    {'day': 'Thursday', 'enabled': true, 'time': '9am - 6pm'},
    {'day': 'Friday', 'enabled': true, 'time': '9am - 6pm'},
    {'day': 'Saturday', 'enabled': true, 'time': '9am - 6pm'},
    {'day': 'Sunday', 'enabled': true, 'time': '9am - 6pm'},
  ];

  final List<Map<String, dynamic>> breakHours = [
    {'day': 'Monday', 'enabled': false, 'time': '9am - 6pm'},
    {'day': 'Tuesday', 'enabled': false, 'time': '9am - 6pm'},
    {'day': 'Wednesday', 'enabled': false, 'time': '9am - 6pm'},
    {'day': 'Thursday', 'enabled': false, 'time': '9am - 6pm'},
    {'day': 'Friday', 'enabled': false, 'time': '9am - 6pm'},
    {'day': 'Saturday', 'enabled': false, 'time': '9am - 6pm'},
    {'day': 'Sunday', 'enabled': false, 'time': '9am - 6pm'},
  ];

  @override
  void initState() {
    _presenter = ScheduleListScreenPresenter(this, widget.presenter);
    final List<bool> initToggles = widget.presenter.getWorkSessionToggles();
    _presenter?.initToggles = initToggles;
    for (int i = 0; i < 7; i++) {
      workingHours[i]['enabled'] = initToggles[i];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.amber),
          onPressed: () {
            onBack();
          },
        ),
        title: Text('Work Schedule', style: TextDecor.homeTitle),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              _presenter?.handleSave(workingHours);
            },
            child: Text('SAVE',
                style: TextDecor.homeTitle.copyWith(color: Colors.amber)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Working hours'),
          ..._buildScheduleList(workingHours),
          // SizedBox(height: 20),
          // _buildSectionTitle('Break hours'),
          // ..._buildScheduleList(breakHours),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: TextDecor.homeTitle),
    );
  }

  List<Widget> _buildScheduleList(List<Map<String, dynamic>> schedule) {
    return schedule.map((day) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Palette.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Switch(
              value: day['enabled'],
              onChanged: (value) {
                setState(() {
                  day['enabled'] = value;
                });
              },
              activeColor: Colors.amber,
            ),
            Expanded(
              child: Text(day['day'],
                  style: TextDecor.homeTitle.copyWith(color: Colors.white)),
            ),
            Text(day['time'],
                style: TextDecor.homeTitle.copyWith(color: Colors.white)),
          ],
        ),
      );
    }).toList();
  }

  @override
  void onSaveSucceeded() {
    UtilWidgets.createSnackBar(context, "Save working hours succeeded");
  }

  @override
  void onBack() {
    Navigator.pop(context);
  }

  @override
  void onPopContext() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void onWaitingProgressBar() {
    UtilWidgets.createLoadingWidget(context);
  }
}
