import 'package:flutter/material.dart';
import 'package:hairvibe/Contract/admin_appointment_detail_contract.dart';
import 'package:hairvibe/Presenter/admin_appointment_detail_presenter.dart';
import 'package:hairvibe/Singletons/appointment_singleton.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/Utility.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/views/admin/admin_home_screen.dart';
import 'package:hairvibe/views/admin_appointment/appointment_calendar.dart';
import 'package:hairvibe/widgets/util_widgets.dart';

class AdminAppointmentDetailPage extends StatefulWidget {
  const AdminAppointmentDetailPage({super.key});
  static const String routeName = 'admin_appointment_detail_page';

  @override
  AdminAppointmentDetailPageState createState() => AdminAppointmentDetailPageState();
}

class AdminAppointmentDetailPageState
    extends State<AdminAppointmentDetailPage> implements AdminAppointmentDetailPageContract {
  final AppointmentSingleton _singleton = AppointmentSingleton.getInstance();
  AdminAppointmentDetailPagePresenter? _presenter;
  late final String customerName;
  late final String appointmentDate;
  late final String avatarUrl;
  late final List<Service> servicesList;
  late final int totalPrice;

  @override
  void initState() {
    _presenter = AdminAppointmentDetailPagePresenter(this);
    customerName = _singleton.getCustomerName();
    appointmentDate = "${_singleton.getAppointmentDate()} ${_singleton.getAppointmentTime()}";
    avatarUrl = _singleton.getCustomerAvatarUrl();
    int sum = 0;
    servicesList = _singleton.getServices().map((service) {
      sum += service.price!;
      return Service(
        name: service.name!,
        price: service.price!
      );
    }).toList();
    totalPrice = sum;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Palette.primary),
          onPressed: () {
            _presenter!.handleBack();
          },
        ),
        title: Text('Appointment Details', style: TextDecor.homeTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (avatarUrl.isNotEmpty)
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 20,
                          foregroundImage: NetworkImage(avatarUrl),
                        )
                      else
                        const CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 20,
                          foregroundImage: AssetImage(AssetHelper.barberAvatar),
                        )
                      ,
                      const SizedBox(width: 8),
                      Text(customerName,
                          style: TextDecor.robo16Semi
                              .copyWith(color: Colors.white)),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 20,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        _presenter!.handleCancelButtonPressed();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Palette.primary),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, color: Palette.primary),
                    const SizedBox(width: 10),
                    Text(appointmentDate,
                        style: TextDecor.inter13Medi
                            .copyWith(color: Colors.white)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Palette.primary),
                ),
                child: Column(
                  children: [
                    ...servicesList.map((service) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(service.name,
                              style: TextDecor.inter13Medi
                                  .copyWith(color: Colors.white)),
                          Text(Utility.formatCurrency(service.price),
                              style: TextDecor.inter13Medi
                                  .copyWith(color: Colors.white)),
                        ],
                      );
                    }),
                    const Divider(color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',
                            style: TextDecor.inter13Medi
                                .copyWith(color: Colors.white)),
                        Text(Utility.formatCurrency(totalPrice),
                            style: TextDecor.inter13Medi
                                .copyWith(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onBack() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void onCancelAppointment() {
    UtilWidgets.createYesNoDialog(
        context: context,
        title: UtilWidgets.NOTIFICATION,
        content: "Do you want to cancel this appointment?",
        onAccept: () {
          Navigator.of(context, rootNavigator: true).pop();
          _presenter!.handleCancelAppointment();
        },
        onCancel: () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
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
  void onCancelAppointmentFailed() {
    UtilWidgets.createSnackBar(context, "Something was wrong. Please try again.");
  }

  @override
  void onCancelAppointmentSucceeded() {
    Navigator.of(context, rootNavigator: true).pop();
  }

}

class Service {
  final String name;
  final int price;

  Service({required this.name, required this.price});
}
