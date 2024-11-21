import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/views/all_barber/barber_image_item.dart';

class BarBerItemDetail extends StatefulWidget {
  const BarBerItemDetail({super.key});

  @override
  State<BarBerItemDetail> createState() => _BarBerItemDetailState();
}

class _BarBerItemDetailState extends State<BarBerItemDetail> {
  final List<String> weekDays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

  List<DateTime> getCurrentWeekDates() {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday % 7;
    DateTime startOfWeek = now.subtract(Duration(days: currentWeekday));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> weekDates = getCurrentWeekDates();
    return Container(
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
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetHelper.barberAvatar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nhat Duy Pham Nguyen',
                    style: TextDecor.serviceListItemTitle,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Pro Barber',
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
                        '4.5',
                        style: TextDecor.barberListItemKind.copyWith(
                          color: Palette.barberListItemRating,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 75,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return BarberImageItem();
              },
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 240,
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
                    width: 240,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: weekDates
                          .map((date) => Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Palette.primary,
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    '${date.day}',
                                    style: TextDecor.weekCalendarDay.copyWith(
                                      color: date.day == DateTime.now().day
                                          ? Palette.inactiveDayWeek
                                          : Palette.serviceListItem,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Palette.primary),
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
            ],
          ),
        ],
      ),
    );
  }
}
