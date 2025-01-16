import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Contract/detail_barber_contract.dart';
import 'package:hairvibe/Presenter/detail_barber_presenter.dart';
import 'package:hairvibe/Singletons/user_singleton.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/observers/data_fetching_subcriber.dart';
import 'package:hairvibe/views/all_barber/photo_tab.dart';
import 'package:hairvibe/views/all_barber/review_tab.dart';
import 'package:hairvibe/widgets/util_widgets.dart';

class DetailBarber extends StatefulWidget {
  const DetailBarber({super.key});
  static const String routeName = 'detail_barber_page';

  @override
  State<DetailBarber> createState() => _DetailBarberState();
}

class _DetailBarberState extends State<DetailBarber>
    implements DetailBarberContract, DataFetchingSubscriber {
  DetailBarberPresenter? _presenter;
  bool isLoading = true;

  final UserSingleton userSingleton = UserSingleton.getInstance();

  @override
  void initState() {
    userSingleton.subscribe(this);
    _presenter = DetailBarberPresenter(this);
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
  void dispose() {
    userSingleton.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              _presenter?.handleBack();
            },
            icon: const Icon(
              FontAwesomeIcons.angleLeft,
              color: Palette.primary,
            ),
          ),
        ),
        body: isLoading ? UtilWidgets.getLoadingWidget() : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width,
            ),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                image: _presenter!.getBarberAvatarUrl().isNotEmpty ?
                  DecorationImage(
                    image: NetworkImage(_presenter!.getBarberAvatarUrl()),
                    fit: BoxFit.cover,
                  )
                :
                  const DecorationImage(
                    image: AssetImage(AssetHelper.logo),
                    fit: BoxFit.cover,
                  )
                ,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _presenter?.getBarberName() ?? 'Barber Name',
              style: TextDecor.detailBarberName,
            ),
            TabBar(
              labelColor: Colors.white,
              indicatorColor: Palette.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelStyle: TextDecor.authTab,
              tabs: const [
                Tab(text: 'REVIEWS'),
                Tab(text: 'PHOTOS'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ReviewsTab(presenter: _presenter!),
                  const PhotosBarberTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onLoadDataSucceed() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void updateData() {
    _presenter?.getData();
  }

  @override
  void onPopContext() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void onWaitingProgressBar() {
    UtilWidgets.createLoadingWidget(context);
  }

  @override
  void onBack() {
    Navigator.pop(context);
  }
}
