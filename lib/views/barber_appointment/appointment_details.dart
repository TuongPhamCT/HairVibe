import 'package:flutter/material.dart';
import 'package:hairvibe/Contract/barber_appointment_detail_contract.dart';
import 'package:hairvibe/Presenter/barber_appointment_detail_presenter.dart';
import 'package:hairvibe/Singletons/appointment_singleton.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/Utility.dart';
import 'package:hairvibe/views/admin/home_screen.dart';
import 'package:hairvibe/views/barber_appointment/appointment_calendar.dart';
import 'package:hairvibe/widgets/util_widgets.dart';

class BarberAppointmentDetailPage extends StatefulWidget {
  const BarberAppointmentDetailPage({super.key});
  static const String routeName = 'barber_appointment_detail_page';

  @override
  BarberAppointmentDetailPageState createState() => BarberAppointmentDetailPageState();
}

class BarberAppointmentDetailPageState
    extends State<BarberAppointmentDetailPage> implements BarberAppointmentDetailPageContract {
  final AppointmentSingleton _singleton = AppointmentSingleton.getInstance();
  BarberAppointmentDetailPagePresenter? _presenter;
  late final String customerName;
  late final String appointmentDate;
  late final String avatarUrl;
  late final List<Service> servicesList;
  late final int totalPrice;

  @override
  void initState() {
    _presenter = BarberAppointmentDetailPagePresenter(this);
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
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 20,
                        foregroundImage: NetworkImage(avatarUrl),
                      ),
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
              SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Palette.primary),
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: Palette.primary),
                    SizedBox(width: 10),
                    Text(appointmentDate,
                        style: TextDecor.inter13Medi
                            .copyWith(color: Colors.white)),
                  ],
                ),
              ),
              SizedBox(height: 20),
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
    Navigator.of(context).pushNamed(AdminHomeScreen.routeName);
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
