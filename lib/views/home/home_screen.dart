import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/all_barber/barber.dart';
import 'package:hairvibe/views/all_service.dart';
import 'package:hairvibe/views/booking/main_booking.dart';
import 'package:hairvibe/widgets/bottom_bar.dart';
import 'package:hairvibe/widgets/list_view/barber_list_item.dart';
import 'package:hairvibe/widgets/list_view/service_list_item.dart';
import 'package:hairvibe/widgets/noti_bell.dart';
import 'package:hairvibe/widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home_page';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _soLuongThongBao = 2;
  final int _listServiceCount = 4;
  final int _currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'HOME',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          NotificationBell(soLuongThongBao: _soLuongThongBao),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: SearchField(),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 55,
                      width: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Palette.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        FontAwesomeIcons.sliders,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Service',
                    style: TextDecor.homeTitle,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AllServiceScreen.routeName);
                    },
                    child: Text(
                      'More',
                      style: TextDecor.leadingForgot,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: _listServiceCount,
                itemBuilder: (context, index) {
                  return const ServiceListItem();
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Barber',
                    style: TextDecor.homeTitle,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(BarberScreen.routeName);
                    },
                    child: Text(
                      'More',
                      style: TextDecor.leadingForgot,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: _listServiceCount,
                itemBuilder: (context, index) {
                  return const BarberListItem();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBarCustom(
        currentIndex: _currentPageIndex,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(MainBooking.routeName);
        },
        backgroundColor: Palette.primary,
        child: const Icon(
          FontAwesomeIcons.plus,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }
}
