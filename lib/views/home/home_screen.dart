import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/widgets/bottom_bar.dart';
import 'package:hairvibe/widgets/list_view/barber_list_item.dart';
import 'package:hairvibe/widgets/list_view/service_list_item.dart';
import 'package:hairvibe/widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home_page';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _soLuongThongBao = 2;
  int _listServiceCount = 4;
  int _currentPageIndex = 0;
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
          Container(
            margin: EdgeInsets.only(right: 30),
            height: 30,
            width: 30,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.solidBell,
                    color: Palette.primary,
                    size: 27,
                  ),
                ),
                Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$_soLuongThongBao',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
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
                  Text(
                    'More',
                    style: TextDecor.leadingForgot,
                  ),
                ],
              ),
              const SizedBox(height: 9),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: _listServiceCount,
                itemBuilder: (context, index) {
                  return ServiceListItem();
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
                  Text(
                    'More',
                    style: TextDecor.leadingForgot,
                  ),
                ],
              ),
              const SizedBox(height: 9),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: _listServiceCount,
                itemBuilder: (context, index) {
                  return BarberListItem();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBarCustom(
        currentIndex: _currentPageIndex,
      ),
    );
  }
}
