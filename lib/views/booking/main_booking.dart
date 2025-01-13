import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hairvibe/Builders/WidgetBuilder/book_barber_item_builder.dart';
import 'package:hairvibe/Contract/main_booking_contract.dart';
import 'package:hairvibe/Models/service_model.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Presenter/main_booking_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/booking/confirm_booking.dart';
import 'package:hairvibe/widgets/list_view/book_barber_item.dart';
import 'package:hairvibe/widgets/list_view/check_service_list_item.dart';
import 'package:hairvibe/widgets/util_widgets.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Builders/WidgetBuilder/check_service_list_item_builder.dart';
import '../../Utility.dart';

class MainBooking extends StatefulWidget {
  const MainBooking({super.key});
  static const String routeName = 'main_booking_page';

  @override
  State<MainBooking> createState() => _MainBookingState();
}

class _MainBookingState extends State<MainBooking> implements MainBookingContract {
  MainBookingPresenter? _presenter;

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final List<bool> _isSelected = List.generate(5, (_) => false);
  int _selectedIndex = -1; // Chỉ mục của Barber được chọn (-1: không chọn)
  String _totalCost = "00,000 VNĐ";

  List<UserModel> barbers = [];
  Map<String, double> ratings = {};
  List<Map<String, dynamic>> services = [];
  List<dynamic> times = [];

  @override
  void initState() {
    _presenter = MainBookingPresenter(this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData();
  }

  Future<void> loadData() async {
    await _presenter?.getData();
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
                  _presenter!.handleBack();
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
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        CheckServiceListItemBuilder builder = CheckServiceListItemBuilder();
                        ServiceModel service = services[index]['serviceModel'];
                        builder.setService(service);
                        builder.setIsChecked(services[index]['isChecked']);
                        builder.setOnChanged(
                            (bool newValue) {
                              _presenter?.handleSelectService(service, index, newValue);
                              services[index]['isChecked'] = newValue;
                            }
                        );
                        return builder.createWidget();
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
                            _presenter!.handleSelectDate(selectedDay, focusedDay);
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
                            times.length,
                            (index) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  fixedSize: Size(size.width * 0.15, 32),
                                  padding: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: BorderSide(
                                      color: times[index]['isChecked']
                                          ? Palette.primary
                                          : Palette.inactiveDayWeek,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  _presenter!.handleSelectTime(index);
                                },
                                child: Text(
                                  '${(times[index]['time'] as TimeOfDay).hour.toString()}:'
                                  '${(times[index]['time'] as TimeOfDay).minute.toString().padLeft(2, '0')}',
                                  style: TextDecor.timeWork.copyWith(
                                    color: times[index]['isChecked']
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
                      itemCount: barbers.length,
                      itemBuilder: (context, index) {
                        BookBarberItemBuilder builder = BookBarberItemBuilder();
                        UserModel barber = barbers[index];
                        builder.setBarber(barber);
                        builder.setRating(Utility.formatRatingValue(ratings[barber.userID]));
                        builder.setIsSelected(index == _selectedIndex);
                        builder.setOnTap(
                          () {
                            _presenter!.handleSelectBarber(barber, index);
                          }
                        );
                        return builder.createWidget();
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
                    _totalCost,
                    style: TextDecor.totalCost,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _presenter!.handleNextPressed();
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

  @override
  void onLoadDataSucceed() {
    setState(() {
      // services
      services = _presenter!.services;

      // barbers
      ratings = _presenter!.ratings;
      barbers = _presenter!.barbers;
      if (barbers.isNotEmpty) {
        _selectedIndex = 0;
      }

      // Time
      times = _presenter!.times;
    });
  }

  @override
  void onNext() {
    Navigator.of(context).pushNamed(ConfirmBooking.routeName);
  }

  @override
  void onSelectBarber(int index) {
    setState(() {
      _selectedIndex = index;
      _totalCost = _presenter!.getTotalCost();
      times = _presenter!.times;
    });
  }

  @override
  void onSelectDate() {
    setState(() {
      _selectedDay = _presenter!.selectedDate!;
      _focusedDay = _presenter!.focusedDate!;
      times = _presenter!.times;
    });
  }

  @override
  void onSelectService() {
    setState(() {
      times = _presenter!.times;
    });
  }

  @override
  void onSelectTime() {
    setState(() {});
  }

  @override
  void onValidatingFailed(String message) {
    UtilWidgets.createSnackBar(context, message);
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
