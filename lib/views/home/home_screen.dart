import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Builders/WidgetBuilder/barber_list_item_builder.dart';
import 'package:hairvibe/Contract/home_screen_contract.dart';
import 'package:hairvibe/Models/rating_repo.dart';
import 'package:hairvibe/Models/service_model.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Presenter/home_screen_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/Utility.dart';
import 'package:hairvibe/views/all_barber/barber.dart';
import 'package:hairvibe/views/all_service.dart';
import 'package:hairvibe/views/booking/main_booking.dart';
import 'package:hairvibe/widgets/bottom_bar.dart';
import 'package:hairvibe/widgets/list_view/barber_list_item.dart';
import 'package:hairvibe/widgets/list_view/service_list_item.dart';
import 'package:hairvibe/widgets/noti_bell.dart';
import 'package:hairvibe/widgets/search_field.dart';
import 'package:hairvibe/widgets/util_widgets.dart';

import '../../Builders/WidgetBuilder/service_list_item_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home_page';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeScreenContract {
  HomeScreenPresenter? _presenter;
  bool isLoading = true;

  List<UserModel> _barberList = [];
  List<ServiceModel> _serviceList = [];
  Map<String, double> _ratings = {};

  final int _soLuongThongBao = 2;
  final int _currentPageIndex = 0;

  @override
  void initState() {
    _presenter = HomeScreenPresenter(this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData();
  }

  Future<void> loadData() async {
    await _presenter?.getData();
  }

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
              isLoading ? UtilWidgets.getLoadingWidget() : ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: _serviceList.length,
                itemBuilder: (context, index) {
                  ServiceListItemBuilder builder = ServiceListItemBuilder();
                  builder.setService(_serviceList[index]);
                  builder.setOnPressed(() {
                    _presenter!.handleServicePressed(builder.service!);
                  });
                  return builder.createWidget();
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
              isLoading ? UtilWidgets.getLoadingWidget() : ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: _barberList.length,
                itemBuilder: (context, index) {
                  BarberListItemBuilder builder = BarberListItemBuilder();
                  UserModel barber = _barberList[index];
                  builder.setBarber(barber);
                  builder.setDescription("Barber");
                  builder.setRating(_ratings[barber.userID] != null ? _ratings[barber.userID]!.toStringAsFixed(1) : "0");
                  builder.setOnPressed(() {
                    _presenter?.handleBarberPressed(barber);
                  });
                  return builder.createWidget();
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

  @override
  void onBarberPressed() {
    // TODO: implement onBarberPressed
  }

  @override
  void onLoadDataSucceed() {
    // TODO: implement onLoadDataSucceed
    setState(() {
      _barberList = _presenter!.barberList;
      _serviceList = _presenter!.serviceList;
      _ratings = _presenter!.ratings;
      isLoading = false;
    });
  }

  @override
  void onServicePressed() {
    // TODO: implement onServicePressed
  }
}
