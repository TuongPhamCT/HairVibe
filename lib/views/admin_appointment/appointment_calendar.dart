import 'package:flutter/material.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Presenter/admin_appointment_presenter.dart';
import 'package:hairvibe/Singletons/notification_singleton.dart';
import 'package:hairvibe/Utility.dart';
import 'package:hairvibe/observers/notification_subcriber.dart';
import 'package:hairvibe/views/admin_appointment/appointment_details.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/noti_bell.dart';
import '../../Contract/admin_appointment_contract.dart';
import '../../Singletons/user_singleton.dart';
import '../../Strategy/BottomBarStrategy/bottom_bar_strategy.dart';
import '../../widgets/util_widgets.dart';

class AdminAppointmentPage extends StatefulWidget {
  const AdminAppointmentPage({super.key});
  static const routeName = 'admin_appointment';
  @override
  AdminAppointmentPageState createState() => AdminAppointmentPageState();
}

class AdminAppointmentPageState extends State<AdminAppointmentPage>
    implements AdminAppointmentPageContract, NotificationSubscriber {
  AdminAppointmentPagePresenter? _presenter;
  final NotificationSingleton _notificationSingleton = NotificationSingleton.getInstance();

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<AppointmentModel> _appointments = []; // No appointments initially
  int _notificationCount = 0;

  bool isLoading = true;

  BottomBarRenderStrategy? bottomBarRenderStrategy;

  @override
  void initState() {
    _presenter = AdminAppointmentPagePresenter(this);
    _notificationSingleton.subscribe(this);
    _notificationCount = _notificationSingleton.getUnreadCount();
    bottomBarRenderStrategy = UserSingleton.getInstance().getBottomBarRenderStrategy(1);
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
  void dispose() {
    _notificationSingleton.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          'APPOINTMENT',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          NotificationBell(notificationCount: _notificationCount),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _presenter?.handleChangeDate(selectedDay);
                  });
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: TextStyle(color: Colors.white),
                  weekendTextStyle: TextStyle(color: Colors.white),
                ),
                headerStyle: HeaderStyle(
                  titleTextStyle: TextDecor.titleCalendar,
                  formatButtonVisible: false,
                  leftChevronIcon: const Icon(Icons.arrow_back, color: Colors.white),
                  rightChevronIcon:
                      Icon(Icons.arrow_forward, color: Colors.white),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.white),
                  weekendStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            if (_appointments.isNotEmpty)
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _appointments.map((appointment) {
                    return GestureDetector(
                      onTap: () {
                        _presenter!.handleSelectAppointment(appointment);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              Utility.formatTimeFromDateTime(appointment.date),
                              style: const TextStyle(color: Colors.white)
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 50,
                            color: Colors.blue,
                            child: Center(
                              child: Text(
                                appointment.customerID ?? "Customer Name",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              )
            else if (isLoading)
              Container(
                width: size.width,
                height: size.height * 0.3,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                ),
                child: UtilWidgets.getLoadingWidget(),
              )
          ],
        ),
      ),
      bottomNavigationBar: bottomBarRenderStrategy?.render(),
    );
  }

  @override
  void onLoadDataSucceeded() {
    if (!mounted) {
      return;
    }
    setState(() {
      isLoading = false;
      _appointments = _presenter!.appointments;
    });
  }

  @override
  void onSelectAppointment() {
    Navigator.of(context).pushNamed(AdminAppointmentDetailPage.routeName);
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
  void onSelectDate() {
    setState(() {
      isLoading = true;
    });
  }

  @override
  void updateNotification() {
    setState(() {
      _notificationCount = _notificationSingleton.getUnreadCount();
    });
  }
}
