import 'package:flutter/material.dart';
import 'package:hairvibe/Contract/confirm_booking_contract.dart';
import 'package:hairvibe/Presenter/confirm_booking_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/booking/success_booking.dart';
import 'package:hairvibe/views/booking/voucher_redeem.dart';

import '../../Models/service_model.dart';
import '../../Singletons/appointment_singleton.dart';
import '../../Utility.dart';
import '../../widgets/util_widgets.dart';

class ConfirmBooking extends StatefulWidget {
  const ConfirmBooking({super.key});
  static const String routeName = 'confirm_booking_page';

  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking>
    implements ConfirmBookingContract {
  ConfirmBookingPresenter? _presenter;
  final AppointmentSingleton _singleton = AppointmentSingleton.getInstance();

  bool _haveVoucher = false;

  @override
  void initState() {
    _presenter = ConfirmBookingPresenter(this);
    _haveVoucher = _presenter!.checkCacheVoucher();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _presenter?.onChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final Map<String, dynamic> data = _singleton.getViewBookingData();
    List<ServiceModel> services =
        data[ViewBookingData.SERVICES] as List<ServiceModel>;
    List<Widget> serviceNames = [];
    List<Widget> servicePrices = [];

    for (ServiceModel service in services) {
      serviceNames.add(Text(
        service.name ?? "Service Name",
        style: TextDecor.label2Appointment,
      ));
      serviceNames.add(const SizedBox(height: 10));

      servicePrices.add(Text(
        Utility.formatCurrency(service.price),
        style: TextDecor.label2Appointment,
      ));
      servicePrices.add(const SizedBox(height: 10));
    }

    if (data[ViewBookingData.DISCOUNT] != null &&
        data[ViewBookingData.DISCOUNT] > 0) {
      serviceNames.add(
        Text(
          'Discount',
          style: TextDecor.label2Appointment,
        ),
      );

      servicePrices.add(
        Text(
          _haveVoucher ? "${data[ViewBookingData.DISCOUNT]}%" : "",
          style: TextDecor.content1Appointment,
        ),
      );
    }

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Palette.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Palette.primary),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: TextDecor.label1Appointment,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Phone',
                          style: TextDecor.label1Appointment,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Booking Date',
                          style: TextDecor.label1Appointment,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Booking Time',
                          style: TextDecor.label1Appointment,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Barber',
                          style: TextDecor.label1Appointment,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[ViewBookingData.NAME],
                          style: TextDecor.content1Appointment,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          data[ViewBookingData.PHONE],
                          style: TextDecor.content1Appointment,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          data[ViewBookingData.BOOKING_DATE],
                          style: TextDecor.content1Appointment,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          data[ViewBookingData.BOOKING_TIME],
                          style: TextDecor.content1Appointment,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          data[ViewBookingData.BARBER],
                          style: TextDecor.content1Appointment,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Palette.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Palette.primary),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: serviceNames,
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: servicePrices,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: !_haveVoucher,
                    child: ElevatedButton(
                      onPressed: () {
                        _presenter!.handleAddVoucherPressed();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(0),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                          const Size(270, 35),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Palette.primary),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: Text(
                        'Add voucher',
                        style: TextDecor.buttonText,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _haveVoucher,
                    child: Container(
                      width: 270,
                      height: 35,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Palette.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text(
                            '1 Voucher',
                            style: TextDecor.robo12Bold,
                          ),
                          Text(
                            ' applied',
                            style: TextDecor.robo12,
                          ),
                          Expanded(child: Container()),
                          InkWell(
                            onTap: () {
                              _presenter!.handleRemoveVoucherPressed();
                            },
                            child: Text(
                              'Remove',
                              style: TextDecor.robo12.copyWith(
                                color: const Color(0xffC82D2D),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: size.width * 0.7,
                    height: 1,
                    color: Palette.primary,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Total: ',
                          style: TextDecor.inter16Bold,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          Utility.formatCurrency(
                              data[ViewBookingData.TOTAL_PRICE]),
                          style: TextDecor.content1Appointment,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await _presenter!.handleConfirmBooking();
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(0),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(size.width * 0.75, 45),
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
                'CONFIRM BOOKING',
                style: TextDecor.buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onAddVoucher() {
    Navigator.of(context).pushNamed(VoucherRedeem.routeName);
  }

  @override
  void onChangeDependencies(bool result) {
    if (result) {
      setState(() {
        _haveVoucher = result;
      });
    }
  }

  @override
  void onConfirmBooking() {
    Navigator.of(context).pushNamed(SuccessBooking.routeName);
  }

  @override
  void onRemoveVoucher() {
    setState(() {
      _haveVoucher = false;
    });
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
