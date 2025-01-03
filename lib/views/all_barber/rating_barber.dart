import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/custom_button.dart';
import 'package:hairvibe/widgets/noti_bell.dart';

class RatingBarberPage extends StatefulWidget {
  const RatingBarberPage({super.key});
  static const routeName = 'rating-barber';

  @override
  State<RatingBarberPage> createState() => _RatingBarberPageState();
}

class _RatingBarberPageState extends State<RatingBarberPage> {
  final int _soLuongThongBao = 3;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Palette.primary,
          ),
        ),
        backgroundColor: Colors.black,
        title: Text(
          'REVIEW',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          NotificationBell(notificationCount: _soLuongThongBao),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(25),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Palette.primary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width,
              ),
              Text(
                'Star Rating',
                style: TextDecor.robo15Semi.copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              RatingBar(
                initialRating: 3,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.yellow,
                  ),
                  half: const Icon(
                    FontAwesomeIcons.starHalfAlt,
                    color: Colors.yellow,
                  ),
                  empty: const Icon(
                    FontAwesomeIcons.star,
                    color: Colors.yellow,
                  ),
                ),
                itemSize: 30,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {},
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                'Review: ',
                style: TextDecor.robo15Semi.copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                style: TextDecor.robo16Semi.copyWith(color: Colors.black),
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'Please enter your reason',
                  hintStyle: TextDecor.inter12Medi,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                onPressed: () {},
                text: 'CONFIRM',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
