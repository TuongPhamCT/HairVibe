import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/admin_appointment/appointment_calendar.dart';

class AdminAppointmentDetailPage extends StatefulWidget {
  @override
  _AdminAppointmentDetailPageState createState() =>
      _AdminAppointmentDetailPageState();
}

class _AdminAppointmentDetailPageState
    extends State<AdminAppointmentDetailPage> {
  final String customerName = "Duy";
  final String appointmentDate = "Tuesday, October 22nd, 2024";
  final List<Service> servicesList = [
    Service(name: "Haircut", price: 10),
    // Co gi fix cho nay lai nha, em Duy test thoi
  ];
  final int totalPrice = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Palette.primary),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminAppointmentPage()),
            );
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
                      ),
                      SizedBox(width: 8),
                      Text(customerName,
                          style: TextDecor.robo16Semi
                              .copyWith(color: Colors.white)),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 20,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        // Mo dialog xac nhan
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
                          Text("\$${service.price}",
                              style: TextDecor.inter13Medi
                                  .copyWith(color: Colors.white)),
                        ],
                      );
                    }).toList(),
                    Divider(color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',
                            style: TextDecor.inter13Medi
                                .copyWith(color: Colors.white)),
                        Text("\$${totalPrice}",
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
}

class Service {
  final String name;
  final int price;

  Service({required this.name, required this.price});
}
