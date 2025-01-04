import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Contract/cancel_appointment_contract.dart';
import 'package:hairvibe/Presenter/cancel_appointment_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/custom_button.dart';
import 'package:hairvibe/widgets/noti_bell.dart';

import '../../widgets/util_widgets.dart';

class CancelAppointmentPage extends StatefulWidget {
  const CancelAppointmentPage({super.key});
  static const routeName = 'cancel-appointment';

  @override
  State<CancelAppointmentPage> createState() => _CancelAppointmentPageState();
}

class _CancelAppointmentPageState extends State<CancelAppointmentPage> implements CancelAppointmentPageContract {
  CancelAppointmentPagePresenter? _presenter;

  final int _soLuongThongBao = 3;
  String? _selectedReason;
  final TextEditingController otherReasonController = TextEditingController();

  final Map<String, String> choices = {
    "choice1" : "Schedule change",
    "choice2" : "Weather condition",
    "choice3" : "I have alternative option",
    "choice4" : "Other"
  };

  @override
  void initState() {
    _presenter = CancelAppointmentPagePresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = choices.entries.map((entry) {
      return RadioListTile<String>(
        fillColor: WidgetStateColor.resolveWith((states) => Colors.white),
        contentPadding: const EdgeInsets.all(0),
        title:
        Text(entry.value, style: TextDecor.robo16Semi),
        value: entry.key,
        groupValue: _selectedReason,
        onChanged: (value) {
          setState(() {
            _selectedReason = value;
          });
        },
      );
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Palette.primary,
          ),
        ),
        backgroundColor: Colors.black,
        title: Text(
          'CANCEL APPOINTMENT',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          NotificationBell(notificationCount: _soLuongThongBao),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please select the reason for cancellations:',
                style: TextDecor.robo16Semi,
              ),
              SizedBox(
                height: 227,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  children: widgets,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: _selectedReason == 'choice4',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Other:', style: TextDecor.robo16Semi),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      controller: otherReasonController,
                      style: TextDecor.robo16Semi.copyWith(color: Colors.black),
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Please enter your reason',
                        hintStyle: TextDecor.inter12Medi,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              CustomButton(
                onPressed: () async {
                  if (_selectedReason == 'choice4') {
                    await _presenter?.handleConfirmPressed(otherReasonController.text);
                  } else {
                    await _presenter?.handleConfirmPressed(choices[_selectedReason]!);
                  }
                },
                text: 'CONFIRM',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onConfirmSucceed() {
    UtilWidgets.createDialog(
        context,
        UtilWidgets.NOTIFICATION,
        "Cancel appointment successfully",
        () {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
  }

  @override
  void onPopContext() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void onWaitingProgressBar() {
    UtilWidgets.createLoadingWidget(context);
  }

  @override
  void onConfirmFailed(String error) {
    UtilWidgets.createSnackBar(context, error);
  }
}
