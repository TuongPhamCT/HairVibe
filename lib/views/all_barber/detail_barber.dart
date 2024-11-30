import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/views/all_barber/photo_tab.dart';
import 'package:hairvibe/views/all_barber/review_tab.dart';
import 'package:hairvibe/views/sign_in_tab.dart';
import 'package:hairvibe/views/sign_up_tab.dart';

class DetailBarber extends StatefulWidget {
  const DetailBarber({super.key});
  static const String routeName = 'detail_barber_page';

  @override
  State<DetailBarber> createState() => _DetailBarberState();
}

class _DetailBarberState extends State<DetailBarber> {
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
              Navigator.pop(context);
            },
            icon: const Icon(
              FontAwesomeIcons.angleLeft,
              color: Palette.primary,
            ),
          ),
        ),
        body: Column(
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
                image: const DecorationImage(
                  image: AssetImage(AssetHelper.barberAvatar),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Duy',
              style: TextDecor.detailBarberName,
            ),
            TabBar(
              labelColor: Colors.white,
              indicatorColor: Palette.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelStyle: TextDecor.authTab,
              tabs: [
                Tab(text: 'REVIEWS'),
                Tab(text: 'PHOTOS'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ReviewsTab(),
                  PhotosBarberTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
