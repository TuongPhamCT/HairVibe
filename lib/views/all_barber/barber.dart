import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Contract/barber_screen_contract.dart';
import 'package:hairvibe/Presenter/barber_screen_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/all_barber/barber_item_detail.dart';

import '../../Models/user_model.dart';
import '../../widgets/util_widgets.dart';

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
    _barberList = _presenter != null ? _presenter!.barberList : [];
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
                  UserModel barber = _barberList[index];
                  return const BarBerItemDetail();
                },
              ),
            ],
          ),
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
      isLoading = false;
    });
  }
}
