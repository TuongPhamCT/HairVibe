import 'package:flutter/material.dart';
import 'package:hairvibe/Models/service_model.dart';
import 'package:hairvibe/Singletons/appointment_singleton.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/Utility.dart';
import 'package:hairvibe/views/home/home_screen.dart';

class ViewBooking extends StatelessWidget {
  const ViewBooking({super.key});
  static const String routeName = 'view_booking_page';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final Map<String, dynamic> data = AppointmentSingleton.getInstance().getViewBookingData();
    List<ServiceModel> services = data[ViewBookingData.SERVICES] as List<ServiceModel>;
    List<Widget> serviceNames = [];
    List<Widget> servicePrices = [];

    for (ServiceModel service in services) {
      serviceNames.add(
        Text(
          service.name ?? "Service Name",
          style: TextDecor.label2Appointment,
        )
      );
      serviceNames.add(const SizedBox(height: 10));

      servicePrices.add(
          Text(
            Utility.formatCurrency(service.price),
            style: TextDecor.label2Appointment,
          )
      );
      servicePrices.add(const SizedBox(height: 10));
    }

    if (data[ViewBookingData.DISCOUNT] > 0) {
      serviceNames.add(
        Text(
          'Discount',
          style: TextDecor.label2Appointment,
        ),
      );

      servicePrices.add(
        Text(
          "${data[ViewBookingData.DISCOUNT]}%",
          style: TextDecor.content1Appointment,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Book Appointment', style: TextDecor.homeTitle),
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
                  SizedBox(
                    width: size.width * 0.35,
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
                  SizedBox(
                    width: size.width * 0.35,
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
                      SizedBox(
                        width: size.width * 0.35,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: serviceNames,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.35,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: servicePrices,
                        ),
                      ),
                    ],
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
                      Text(
                        'Total: ',
                        style: TextDecor.inter16Bold,
                      ),
                      Text(
                        Utility.formatCurrency(data[ViewBookingData.TOTAL_PRICE]),
                        style: TextDecor.content1Appointment,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
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
                'BACK TO HOME',
                style: TextDecor.buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
