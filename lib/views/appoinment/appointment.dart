import 'package:flutter/material.dart';
import 'package:hairvibe/Contract/appointment_tab_contract.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Presenter/appointment_tab_presenter.dart';
import 'package:hairvibe/Singletons/notification_singleton.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/observers/notification_subcriber.dart';
import 'package:hairvibe/views/appoinment/cancelled_tab.dart';
import 'package:hairvibe/views/appoinment/completed_tab.dart';
import 'package:hairvibe/views/appoinment/upcoming_tab.dart';
import 'package:hairvibe/views/booking/main_booking.dart';
import 'package:hairvibe/widgets/bottom_bar.dart';
import 'package:hairvibe/widgets/noti_bell.dart';
import 'package:hairvibe/widgets/util_widgets.dart';

import '../booking/view_booking.dart';
import 'cancel_appointment.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});
  static const routeName = 'appointment';

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    implements AppointmentTabContract, NotificationSubscriber {
  AppointmentTabPresenter? _presenter;
  final NotificationSingleton notificationSingleton = NotificationSingleton.getInstance();

  List<AppointmentModel> cancelledAppointments = [];
  List<AppointmentModel> completedAppointments = [];
  List<AppointmentModel> upcomingAppointments = [];

  bool isLoading = true;

  final int _currentPageIndex = 1;
  int _soLuongThongBao = 2;

  @override
  void initState() {
    _soLuongThongBao = notificationSingleton.getUnreadCount();
    _presenter = AppointmentTabPresenter(this);
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
        backgroundColor: Colors.black,
        title: Text(
          'APPOINTMENT',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          NotificationBell(notificationCount: _soLuongThongBao),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            TabBar(
              labelColor: Colors.white,
              indicatorColor: Palette.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelStyle: TextDecor.authTab,
              tabs: const [
                Tab(text: 'UPCOMING'),
                Tab(text: 'COMPLETED'),
                Tab(text: 'CANCELLED'),
              ],
            ),
            Expanded(
              child: isLoading ? UtilWidgets.getLoadingWidget() : TabBarView(
                children: [
                  UpcomingTab(
                    presenter: _presenter!,
                    appointments: upcomingAppointments,
                  ),
                  CompletedTab(
                    presenter: _presenter!,
                    appointments: completedAppointments,
                  ),
                  CancelledTab(
                    presenter: _presenter!,
                    appointments: cancelledAppointments,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarCustom(
        currentIndex: _currentPageIndex,
      ),
    );
  }

  @override
  void onLoadDataSucceed() {
    setState(() {
      completedAppointments = _presenter!.completedAppointments;
      cancelledAppointments = _presenter!.cancelledAppointments;
      upcomingAppointments = _presenter!.upcomingAppointments;
      isLoading = false;
    });
  }

  @override
  void onCancelPressed() {
    Navigator.of(context).pushNamed(CancelAppointmentPage.routeName);
  }

  @override
  void onRebookPressed() {
    Navigator.of(context).pushNamed(MainBooking.routeName);
  }

  @override
  void onViewReceiptPressed() {
    Navigator.of(context).pushNamed(ViewBooking.routeName);
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
  void updateNotification() {
    setState(() {
      _soLuongThongBao = notificationSingleton.getUnreadCount();
    });
  }
}
