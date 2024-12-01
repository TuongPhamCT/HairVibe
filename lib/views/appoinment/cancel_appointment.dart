import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/custom_button.dart';
import 'package:hairvibe/widgets/noti_bell.dart';

class CancelAppointmentPage extends StatefulWidget {
  const CancelAppointmentPage({super.key});
  static const routeName = 'cancel-appointment';

  @override
  State<CancelAppointmentPage> createState() => _CancelAppointmentPageState();
}

class _CancelAppointmentPageState extends State<CancelAppointmentPage> {
  final int _soLuongThongBao = 3;
  String? _selectedReason;
  @override
  Widget build(BuildContext context) {
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
          NotificationBell(soLuongThongBao: _soLuongThongBao),
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
                  children: [
                    RadioListTile<String>(
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      contentPadding: const EdgeInsets.all(0),
                      title:
                          Text('Schedule Change', style: TextDecor.robo16Semi),
                      value: 'choice1',
                      groupValue: _selectedReason,
                      onChanged: (value) {
                        setState(() {
                          _selectedReason = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      contentPadding: const EdgeInsets.all(0),
                      title: Text('Weather Condition',
                          style: TextDecor.robo16Semi),
                      value: 'choice2',
                      groupValue: _selectedReason,
                      onChanged: (value) {
                        setState(() {
                          _selectedReason = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      contentPadding: const EdgeInsets.all(0),
                      title: Text('I have alternative_option',
                          style: TextDecor.robo16Semi),
                      value: 'choice3',
                      groupValue: _selectedReason,
                      onChanged: (value) {
                        setState(() {
                          _selectedReason = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      contentPadding: const EdgeInsets.all(0),
                      title: Text('Other', style: TextDecor.robo16Semi),
                      value: 'choice4',
                      groupValue: _selectedReason,
                      onChanged: (value) {
                        setState(() {
                          _selectedReason = value;
                        });
                      },
                    ),
                  ],
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
                onPressed: () {},
                text: 'CONFIRM',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
