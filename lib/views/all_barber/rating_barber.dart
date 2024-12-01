import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
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
          'CANCEL APPOINTMENT',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          NotificationBell(soLuongThongBao: _soLuongThongBao),
        ],
      ),
    );
  }
}
