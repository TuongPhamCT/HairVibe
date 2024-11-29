import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/booking/confirm_booking.dart';
import 'package:hairvibe/widgets/list_view/book_barber_item.dart';
import 'package:hairvibe/widgets/list_view/check_service_list_item.dart';
import 'package:table_calendar/table_calendar.dart';

class MainBooking extends StatefulWidget {
  const MainBooking({super.key});
  static const String routeName = 'main_booking_page';

  @override
  State<MainBooking> createState() => _MainBookingState();
}

class _MainBookingState extends State<MainBooking> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<bool> _isSelected = List.generate(5, (_) => false);

  int _selectedIndex = -1; // Chỉ mục của item được chọn (-1: không chọn)
  final List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5'
  ];

  final List<Map<String, dynamic>> items = List.generate(
    10,
    (index) => {
      'title': 'Item $index',
      'isChecked': false,
    },
  );

  void updateCheckState(int index, bool isChecked) {
    setState(() {
      items[index]['isChecked'] = isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: 0,
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel', style: TextDecor.leadingForgot),
              ),
            ),
            Text('Book Appointment', style: TextDecor.homeTitle),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select service',
                    style: TextDecor.homeTitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 358,
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return CheckServiceListItem(
                          title: items[index]['title'],
                          isChecked: items[index]['isChecked'],
                          onChanged: (bool newValue) {
                            updateCheckState(index, newValue);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Select date & time',
                    style: TextDecor.homeTitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Palette.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        TableCalendar(
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          },
                          headerStyle: HeaderStyle(
                            titleTextStyle: TextDecor.titleCalendar,
                            formatButtonVisible: false,
                            leftChevronIcon: const Icon(
                              CupertinoIcons.back,
                              color: Colors.white,
                            ),
                            rightChevronIcon: const Icon(
                              CupertinoIcons.forward,
                              color: Colors.white,
                            ),
                            titleCentered: true,
                          ),
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextDecor.dayOfWeekCalendar,
                            weekendStyle: TextDecor.dayOfWeekCalendar,
                          ),
                          calendarStyle: CalendarStyle(
                            selectedDecoration: const BoxDecoration(
                              color: Palette.primary,
                              shape: BoxShape.circle,
                            ),
                            selectedTextStyle: TextDecor.homeTitle,
                            defaultTextStyle: TextDecor.dayOfWeekCalendar,
                            todayTextStyle:
                                TextDecor.dayOfWeekCalendar.copyWith(
                              color: Palette.todayText,
                            ),
                            weekendTextStyle: TextDecor.dayOfWeekCalendar,
                            outsideDaysVisible: false,
                            todayDecoration: const BoxDecoration(
                              color: Palette.todayBackground,
                              shape: BoxShape.circle,
                            ),
                          ),
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: _focusedDay,
                          currentDay: DateTime.now(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            5,
                            (index) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  fixedSize: Size(size.width * 0.15, 32),
                                  padding: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: BorderSide(
                                      color: _isSelected[index]
                                          ? Palette.primary
                                          : Palette.inactiveDayWeek,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isSelected[index] = !_isSelected[index];
                                  });
                                },
                                child: Text(
                                  (index * 3 + 7).toString() + ':00',
                                  style: TextDecor.timeWork.copyWith(
                                    color: _isSelected[index]
                                        ? Palette.primary
                                        : Palette.inactiveDayWeek,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Select barber',
                    style: TextDecor.homeTitle,
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return BookBarberItem(
                          title: _items[index],
                          isSelected: index == _selectedIndex,
                          onTap: () {
                            setState(() {
                              _selectedIndex =
                                  index; // Cập nhật chỉ mục của item được chọn
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
              width: size.width,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Palette.primary,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '200k',
                    style: TextDecor.totalCost,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(ConfirmBooking.routeName);
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                        const Size(125, 45),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Palette.primary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      'NEXT',
                      style: TextDecor.buttonText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
