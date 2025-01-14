import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Builders/WidgetBuilder/widget_builder_director.dart';
import 'package:hairvibe/Contract/all_service_screen_contract.dart';
import 'package:hairvibe/Models/service_model.dart';
import 'package:hairvibe/Presenter/all_service_screen_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/commands/all_services/all_services_press_service_command.dart';
import 'package:hairvibe/widgets/util_widgets.dart';

import '../Builders/WidgetBuilder/service_list_item_builder.dart';
import 'booking/main_booking.dart';

class AllServiceScreen extends StatefulWidget {
  const AllServiceScreen({super.key});
  static const String routeName = 'all_service_page';

  @override
  State<AllServiceScreen> createState() => _AllServiceScreenState();
}

class _AllServiceScreenState extends State<AllServiceScreen> implements AllServiceScreenContract {
  AllServiceScreenPresenter? _presenter;

  List<ServiceModel> _serviceList = [];

  bool isLoading = true;

  @override
  void initState() {
    _presenter = AllServiceScreenPresenter(this);
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
        child: isLoading ? UtilWidgets.getLoadingWidget() : Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All of our service',
                style: TextDecor.homeTitle,
              ),
              const SizedBox(
                height: 25,
              ),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: _serviceList.length,
                itemBuilder: (context, index) {
                  CustomizedWidgetBuilderDirector director = CustomizedWidgetBuilderDirector();
                  ServiceListItemBuilder builder = ServiceListItemBuilder();
                  director.makePressableServiceItem(
                      builder: builder,
                      model: _serviceList[index],
                      onPressed: AllServicesPressServiceCommand(
                          presenter: _presenter,
                          serviceModel: _serviceList[index]
                      )
                  );
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
  void onLoadDataSucceed() {
    setState(() {
      _serviceList = _presenter!.serviceList;
      isLoading = false;
    });
  }

  @override
  void onServicePressed() {
    Navigator.of(context).pushNamed(MainBooking.routeName);
  }
}
