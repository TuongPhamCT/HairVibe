import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/booking/view_booking.dart';
import 'package:hairvibe/views/home/home_screen.dart';
import 'package:hairvibe/widgets/custom_button.dart';

class SuccessBooking extends StatelessWidget {
  const SuccessBooking({super.key});
  static const String routeName = 'sucess_booking_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Book Appointment', style: TextDecor.homeTitle),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double iconSize = constraints.maxWidth * 0.4;
          double padding = constraints.maxWidth * 0.1;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: constraints.maxHeight * 0.1),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Palette.primary,
                  size: iconSize,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Booking Successful',
                style: TextDecor.inter27Semi,
              ),
              SizedBox(height: constraints.maxHeight * 0.1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: CustomButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(ViewBooking.routeName);
                  },
                  text: 'View E-Receipt',
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(HomeScreen.routeName);
                  },
                  child: Text(
                    'Back to Home',
                    style: TextDecor.inter19Semi,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
