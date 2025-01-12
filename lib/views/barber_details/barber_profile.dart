import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Contract/detail_barber_contract.dart';
import 'package:hairvibe/Models/rating_model.dart';
import 'package:hairvibe/Presenter/detail_barber_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/widgets/util_widgets.dart';
import 'package:hairvibe/views/barber_details/barber_info.dart';
import 'package:hairvibe/views/barber_details/barber_photo.dart';
import 'package:hairvibe/views/barber_details/barber_review.dart';
import 'package:hairvibe/widgets/barber_bottom_bar.dart';

class BarberProfilePage extends StatefulWidget {
  const BarberProfilePage({super.key});
  static const String routeName = 'barber_profile_page';

  @override
  State<BarberProfilePage> createState() => _BarberProfilePageState();
}

class _BarberProfilePageState extends State<BarberProfilePage> {
  bool isLoading = true;
  String barberName = 'Barber Name';
  String barberAvatarUrl = 'https://example.com/default_avatar.jpg';
  final int _currentPageIndex = 1;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    // Simulate data fetching
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isLoading = false;
      barberName = 'John Doe'; // Example data
      barberAvatarUrl = 'https://example.com/avatar.jpg'; // Example data
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
        ),
        body: isLoading
            ? UtilWidgets.getLoadingWidget()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   width: size.width,
                  // ),
                  // Container(
                  //   height: 100,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(80),
                  //     image: DecorationImage(
                  //       image: NetworkImage(barberAvatarUrl),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: NetworkImage(barberAvatarUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -40,
                        left: MediaQuery.of(context).size.width / 2 - 40,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(AssetHelper.logo),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Text(
                    barberName,
                    style: TextDecor.detailBarberName,
                  ),
                  TabBar(
                    labelColor: Colors.white,
                    indicatorColor: Palette.primary,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelStyle: TextDecor.authTab,
                    tabs: const [
                      Tab(text: 'INFO'),
                      Tab(text: 'REVIEWS'),
                      Tab(text: 'PHOTOS'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        BarberInfoTab(),
                        BarberReviewTab(ratings: [], users: {}),
                        BarberPhotoTab(),
                        // Update as needed
                      ],
                    ),
                  ),
                ],
              ),
        bottomNavigationBar:
            BarberBottomNavigationBar(currentIndex: _currentPageIndex),
      ),
    );
  }
}
