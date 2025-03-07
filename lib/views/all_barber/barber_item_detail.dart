import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairvibe/Commands/command_interface.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/views/all_barber/barber_image_item.dart';

class BarberItemDetail extends StatefulWidget {
  final String? barberName;
  final String? image;
  final String? description;
  final String? rating;
  final List<int>? workSessions;
  final CommandInterface? onDetailPressed;
  final CommandInterface? onBookPressed;

  const BarberItemDetail({
      super.key,
      required this.barberName,
      required this.image,
      required this.description,
      required this.rating,
      required this.workSessions,
      required this.onDetailPressed,
      required this.onBookPressed
  });

  @override
  State<BarberItemDetail> createState() => _BarberItemDetailState();
}

class _BarberItemDetailState extends State<BarberItemDetail> {
  final List<String> weekDays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  List<DateTime> getCurrentWeekDates() {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday - 1;
    DateTime startOfWeek = now.subtract(Duration(days: currentWeekday));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> weekDates = getCurrentWeekDates();
    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          onTap: () {
            widget.onDetailPressed?.execute();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Palette.primary.withOpacity(0.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: widget.image != null && widget.image!.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(widget.image!),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage(AssetHelper.logo),
                              fit: BoxFit.cover,
                            ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.barberName ?? "Barber Name",
                            style: TextDecor.serviceListItemTitle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.description ?? "Barber",
                            style: TextDecor.barberListItemKind,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Palette.primary,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.rating ?? "0.0",
                                style: TextDecor.barberListItemKind.copyWith(
                                  color: Palette.barberListItemRating,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 9,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: constraints.maxWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: weekDays
                            .map((day) => Expanded(
                                  child: Center(
                                    child: Text(
                                      day,
                                      style: TextDecor.weekCalendarDay,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 3),
                    // Hiển thị các ngày trong tuần
                    SizedBox(
                      width: constraints.maxWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: weekDates
                            .map((date) => Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: widget.workSessions != null &&
                                            widget.workSessions!
                                                .contains(date.weekday)
                                        ? Palette.workDayWeek
                                        : Palette.freeDayWeek,
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${date.day}',
                                      style: TextDecor.weekCalendarDay.copyWith(
                                        color: date.day == DateTime.now().day
                                            ? Palette.activeDayWeek
                                            : Palette.inactiveDayWeek,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onBookPressed?.execute();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Palette.primary),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      'BOOK',
                      style: TextDecor.buttonText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
