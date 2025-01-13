import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hairvibe/Contract/admin_home_screen_contract.dart';
import 'package:hairvibe/Presenter/admin_home_screen_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/Utility.dart';
import 'package:hairvibe/observers/notification_subcriber.dart';
import 'package:hairvibe/widgets/noti_bell.dart';
import 'package:hairvibe/widgets/admin_bottom_bar.dart';
import 'package:hairvibe/widgets/util_widgets.dart';

import '../../Singletons/notification_singleton.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});
  static const routeName = 'admin_home';
  @override
  AdminHomeScreenState createState() => AdminHomeScreenState();
}

class AdminHomeScreenState extends State<AdminHomeScreen>
    implements AdminHomeScreenContract, NotificationSubscriber {
  final NotificationSingleton _notificationSingleton =
      NotificationSingleton.getInstance();
  AdminHomeScreenPresenter? _presenter;

  int appointmentCount = 0;
  int barberCount = 4;
  int customerCount = 4;
  int serviceCount = 4;
  double bookedHours = 0.0;
  String completedAppointments = "";
  int _notificationCount = 0;
  final int _currentPageIndex = 0;
  List<double> appointmentColumnsHeight = List.filled(7, 0.0);
  List<double> bookHoursColumnsHeight = List.filled(7, 0.0);

  bool isLoading = true;

  @override
  void initState() {
    _presenter = AdminHomeScreenPresenter(this);
    _notificationSingleton.subscribe(this);
    _notificationCount = _notificationSingleton.getUnreadCount();
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
        title: Text('HOME', style: TextDecor.homeTitle),
        centerTitle: true,
        actions: [
          NotificationBell(notificationCount: _notificationCount),
        ],
      ),
      body: isLoading ? UtilWidgets.getLoadingWidget() : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildCard(
                      title: 'TODAY SCHEDULE',
                      content: appointmentCount == 0
                          ? 'No appointment.'
                          : '$appointmentCount',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildSummaryCard('Barber', barberCount)),
                  Expanded(child: _buildSummaryCard('Customer', customerCount)),
                  Expanded(child: _buildSummaryCard('Service', serviceCount)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildCard(
                      title: 'COMPLETED APPOINTMENT',
                      content: completedAppointments,
                      lineColor: Colors.blue,
                      columnsHeight: bookHoursColumnsHeight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildCard(
                      title: 'HOURS BOOKED',
                      content: "$bookedHours hours",
                      lineColor: Palette.primary,
                      columnsHeight: bookHoursColumnsHeight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AdminBottomBar(
        currentIndex: _currentPageIndex,
      ),
    );
  }

  Widget _buildCard(
      {required String title,
      required String content,
      List<double>? columnsHeight,
      Color? lineColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Palette.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextDecor.homeTitle.copyWith(color: Colors.white)),
          const SizedBox(height: 8),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(content,
                  style: TextDecor.inter13Medi.copyWith(color: Colors.white)),
            ),
          ),
          if (lineColor != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  7,
                  (index) => Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: columnsHeight![index],
                        color: lineColor,
                      ),
                      const SizedBox(height: 8),
                      Text(AdminHomeScreenPresenter.dayOfWeeks[index],
                          style: TextDecor.inter13Medi
                              .copyWith(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, int count) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Palette.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(title,
              style: TextDecor.robo16Semi.copyWith(color: Colors.white)),
          const SizedBox(height: 8),
          Text('$count',
              style: TextDecor.inter13Medi.copyWith(color: Colors.white)),
        ],
      ),
    );
  }

  @override
  void onLoadDataSucceeded() {
    int completedAppointmentsCount =
        _presenter!.getTotalCompletedAppointmentsCount();
    double bookedHoursCount = _presenter!.getTotalBookedHoursCount();

    // Calculate Columns height
    const double highestColumns = 40;

    appointmentColumnsHeight = List.generate(7, (index) => 2);
    bookHoursColumnsHeight = List.generate(7, (index) => 2);

    int maxAppointmentIndex = 0;
    int maxBookedHoursIndex = 0;
    for (int i = 0; i < 7; i++) {
      appointmentColumnsHeight[i] = _presenter!
          .getCompletedAppointmentsCount(
              dayOfWeeks: AdminHomeScreenPresenter.dayOfWeeks[i])
          .toDouble();

      bookHoursColumnsHeight[i] = _presenter!
          .getBookedHourCount(
              dayOfWeeks: AdminHomeScreenPresenter.dayOfWeeks[i])
          .toDouble();

      if (appointmentColumnsHeight[i] >
          appointmentColumnsHeight[maxAppointmentIndex]) {
        maxAppointmentIndex = i;
      }

      if (bookHoursColumnsHeight[i] >
          bookHoursColumnsHeight[maxBookedHoursIndex]) {
        maxBookedHoursIndex = i;
      }
    }

    double highestAppointmentHeight =
        appointmentColumnsHeight[maxAppointmentIndex];
    double highestBookedHoursHeight =
        bookHoursColumnsHeight[maxBookedHoursIndex];

    for (int i = 0; i < 7; i++) {
      if (highestAppointmentHeight > 0) {
        appointmentColumnsHeight[i] = appointmentColumnsHeight[i] /
            highestAppointmentHeight *
            highestColumns + 2;
      } else {
        appointmentColumnsHeight[i] == 2;
      }

      if (highestBookedHoursHeight > 0) {
        bookHoursColumnsHeight[i] = bookHoursColumnsHeight[i] /
                highestBookedHoursHeight *
                highestColumns + 2;
      } else {
        bookHoursColumnsHeight[i] = 2;
      }

    }

    if (!mounted) {
      return;
    }

    setState(() {
      serviceCount = _presenter!.servicesCount;
      appointmentCount = _presenter!.todayAppointmentCount;
      customerCount = _presenter!.customerCount;
      barberCount = _presenter!.barberCount;
      bookedHours = Utility.roundDouble(bookedHoursCount, 1);
      if (completedAppointmentsCount > 0) {
        completedAppointments = "$completedAppointmentsCount";
      } else {
        completedAppointments = 'No completed appointments.';
      }
      isLoading = false;
    });
  }

  @override
  void updateNotification() {
    setState(() {
      _notificationCount = _notificationSingleton.getUnreadCount();
    });
  }
}
