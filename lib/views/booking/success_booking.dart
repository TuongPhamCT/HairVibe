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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Book Appointment', style: TextDecor.homeTitle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: size.width, height: size.height * 0.24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.check_circle,
              color: Palette.primary,
              size: 200,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Booking Successful',
            style: TextDecor.inter27Semi,
          ),
          SizedBox(width: size.width, height: size.height * 0.2),
          CustomButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ViewBooking.routeName);
              },
              text: 'View E-Receipt'),
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
      ),
    );
  }
}
