import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Contract/barber_screen_contract.dart';
import 'package:hairvibe/Builders/WidgetBuilder/barber_item_detail_builder.dart';
import 'package:hairvibe/Presenter/barber_screen_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/all_barber/barber_item_detail.dart';
import 'package:hairvibe/views/booking/main_booking.dart';

import '../../Models/user_model.dart';
import '../../widgets/util_widgets.dart';
import 'detail_barber.dart';

class BarberScreen extends StatefulWidget {
  const BarberScreen({super.key});
  static const String routeName = 'barber_page';

  @override
  State<BarberScreen> createState() => _BarberScreenState();
}

class _BarberScreenState extends State<BarberScreen> implements BarberScreenContract {
  BarberScreenPresenter? _presenter;
  bool isLoading = true;

  List<UserModel> _barberList = [];
  Map<String, double> _ratings = {};

  @override
  void initState() {
    _presenter = BarberScreenPresenter(this);
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
          'ALL SERVICES',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Our best barber',
                style: TextDecor.homeTitle,
              ),
              const SizedBox(
                height: 25,
              ),
              isLoading ? UtilWidgets.getLoadingWidget() : ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: _barberList.length,
                itemBuilder: (context, index) {
                  BarberItemDetailBuilder builder = BarberItemDetailBuilder();
                  UserModel barber = _barberList[index];
                  builder.setBarber(barber);
                  builder.setDescription("Barber");
                  builder.setRating(_ratings[barber.userID] != null ? _ratings[barber.userID]!.toStringAsFixed(1) : "0.0");
                  builder.setOnDetailPressed(() {
                    _presenter?.handleDetailBarberPressed(barber);
                  });
                  builder.setOnBookPressed(() {
                    _presenter?.handleBookBarberPressed(barber);
                  });
                  return builder.createWidget();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onBookBarberPressed() {
    Navigator.of(context).pushNamed(MainBooking.routeName);
  }

  @override
  void onLoadDataSucceed() {
    setState(() {
      _barberList = _presenter != null ? _presenter!.barberList : [];
      _ratings = _presenter != null ? _presenter!.ratings : {};
      isLoading = false;
    });
  }

  @override
  void onDetailBarberPressed() {
    Navigator.of(context).pushNamed(DetailBarber.routeName);
  }
}
