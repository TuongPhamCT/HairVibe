import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/views/appoinment/cancel_appointment.dart';
import 'package:hairvibe/views/booking/view_booking.dart';
import 'package:hairvibe/widgets/appoiment_button.dart';

class UpcomingAppointmentItem extends StatefulWidget {
  const UpcomingAppointmentItem({super.key});

  @override
  State<UpcomingAppointmentItem> createState() =>
      _UpcomingAppointmentItemState();
}

class _UpcomingAppointmentItemState extends State<UpcomingAppointmentItem> {
  bool isRemind = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'October 10, 2024 - 10:00 AM',
                style: TextDecor.inter13Medi,
              ),
              Expanded(child: Container()),
              Text(
                'Remind me',
                style: TextDecor.inter10Medi,
              ),
              Transform.scale(
                scale: 0.6,
                child: Switch(
                  value: isRemind,
                  onChanged: (value) {
                    setState(() {
                      isRemind = value;
                    });
                  },
                  activeColor: Colors.white,
                  focusColor: Palette.primary,
                  hoverColor: Palette.primary,
                  activeTrackColor: Palette.primary,
                  inactiveThumbColor: Palette.primary,
                  inactiveTrackColor: Colors.white,
                  trackOutlineColor: MaterialStateColor.resolveWith(
                      (states) => Palette.primary),
                ),
              ),
            ],
          ),
          Container(
            height: 1,
            color: Palette.backgroundColor,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(AssetHelper.barberAvatar),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Duy',
                    style:
                        TextDecor.searchHintText.copyWith(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Service ID: 123456', style: TextDecor.inter10Medi),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 1,
            color: Palette.backgroundColor,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppointmentButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(CancelAppointmentPage.routeName);
                },
                width: 140,
                backgroundColor: Colors.white,
                borderSide: const BorderSide(color: Palette.primary, width: 2),
                child: Text(
                  'Cancel',
                  style: TextDecor.inter13Semi.copyWith(color: Palette.primary),
                ),
              ),
              AppointmentButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ViewBooking.routeName);
                },
                width: 140,
                backgroundColor: Palette.primary,
                child: Text(
                  'View Receipt',
                  style: TextDecor.inter13Semi,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
