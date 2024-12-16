import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/Utility.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/views/appoinment/cancel_appointment.dart';
import 'package:hairvibe/views/booking/view_booking.dart';
import 'package:hairvibe/widgets/appoiment_button.dart';

class UpcomingAppointItem extends StatefulWidget {
  final DateTime? date;
  final String? barberName;
  final String? serviceID;
  final VoidCallback? onCancelPressed;
  final VoidCallback? onViewReceiptPressed;
  const UpcomingAppointItem({
    super.key,
    this.date,
    this.barberName,
    this.serviceID,
    this.onCancelPressed,
    this.onViewReceiptPressed
  });

  @override
  State<UpcomingAppointItem> createState() =>
      _UpcomingAppointItemState();
}

class _UpcomingAppointItemState extends State<UpcomingAppointItem> {
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
                Utility.formatStringFromDateTime(widget.date),
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
                    widget.barberName ?? "Barber Name",
                    style:
                        TextDecor.searchHintText.copyWith(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Service ID: ${widget.serviceID}', style: TextDecor.inter10Medi),
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
                onPressed: widget.onCancelPressed,
                width: 140,
                backgroundColor: Colors.white,
                borderSide: const BorderSide(color: Palette.primary, width: 2),
                child: Text(
                  'Cancel',
                  style: TextDecor.inter13Semi.copyWith(color: Palette.primary),
                ),
              ),
              AppointmentButton(
                // onPressed: () {
                //   Navigator.of(context).pushNamed(ViewBooking.routeName);
                // },
                onPressed: widget.onViewReceiptPressed,
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
