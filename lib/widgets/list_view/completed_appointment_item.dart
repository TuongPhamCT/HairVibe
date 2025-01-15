import 'package:flutter/material.dart';
import 'package:hairvibe/Commands/command_interface.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/Utility.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/widgets/appoiment_button.dart';

class CompletedAppointItem extends StatefulWidget {
  final DateTime? date;
  final String? barberName;
  final String? serviceID;
  final CommandInterface? onViewReceiptPressed;

  const CompletedAppointItem({
    super.key,
    this.date,
    this.barberName,
    this.serviceID,
    this.onViewReceiptPressed
  });

  @override
  State<CompletedAppointItem> createState() => _CompletedAppointItemState();
}

class _CompletedAppointItemState extends State<CompletedAppointItem> {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Utility.formatStringFromDateTime(widget.date),
            style: TextDecor.inter13Medi,
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
          AppointmentButton(
            onPressed: () {
              widget.onViewReceiptPressed?.execute();
            },
            width: double.maxFinite,
            backgroundColor: Palette.primary,
            child: Text(
              'View Receipt',
              style: TextDecor.inter13Semi,
            ),
          ),
        ],
      ),
    );
  }
}
