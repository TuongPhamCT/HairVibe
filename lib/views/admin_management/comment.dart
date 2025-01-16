import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hairvibe/Builders/WidgetBuilder/widget_builder_director.dart';
import 'package:hairvibe/Contract/admin_comment_page_contract.dart';
import 'package:hairvibe/Presenter/admin_comment_page_presenter.dart';
import 'package:hairvibe/Singletons/barber_singleton.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/commands/admin_comment_page/comment_delete_service_command.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/views/admin_management/add_service.dart';
import 'package:hairvibe/widgets/admin_bottom_bar.dart';

import '../../Builders/WidgetBuilder/review_item_builder.dart';
import '../../Builders/WidgetBuilder/service_list_item_builder.dart';
import '../../Models/rating_model.dart';
import '../../Models/user_model.dart';
import '../../widgets/util_widgets.dart';

class AdminCommentPage extends StatefulWidget {
  const AdminCommentPage({super.key});
  static const String routeName = 'admin_comment';

  @override
  AdminCommentPageState createState() => AdminCommentPageState();
}

class AdminCommentPageState extends State<AdminCommentPage>
    with SingleTickerProviderStateMixin
    implements AdminCommentPageContract {
  AdminCommentPagePresenter? _presenter;
  final CustomizedWidgetBuilderDirector director = CustomizedWidgetBuilderDirector();
  late TabController _tabController;
  final int _currentPageIndex = 3;
  bool isLoading = true;
  String barberName = "";
  String avatarUrl = "";

  @override
  void initState() {
    _presenter = AdminCommentPagePresenter(this);
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
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
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          'COMMENTS',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        actions: const [],
      ),
      body: isLoading
          ? UtilWidgets.getLoadingWidget()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage(AssetHelper.logo),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -40,
                        left: MediaQuery.of(context).size.width / 2 - 40,
                        child: avatarUrl.isNotEmpty
                          ? CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(avatarUrl),
                          )
                          : const CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(AssetHelper.logo),
                          ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Text(
                    barberName,
                    style: TextDecor.homeTitle.copyWith(color: Colors.white),
                  ),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: Palette.primary,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: 'REVIEWS'),
                      Tab(text: 'SERVICES'),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.39,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildReviews(),
                        _buildServices(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: AdminBottomBar(currentIndex: _currentPageIndex),
    );
  }

  Widget _buildReviews() {
    if (_presenter!.ratings.isEmpty) {
      return const Center(
        child: Text(
          'There is no review',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: _presenter!.ratings.length, // Example count
      itemBuilder: (context, index) {
        ReviewItemBuilder builder = ReviewItemBuilder();
        RatingModel rating = _presenter!.ratings[index];
        director.makeReviewItem(
            builder: builder,
            user: _presenter!.users[rating.userID!]!,
            rating: rating,
        );
        return builder.createWidget();
      },
    );
  }

  Widget _buildServices() {
    if (_presenter!.services.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'There is no service',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AddServicePage.routeName);
              },
              child: const Text(
                'ADD SERVICE',
                style: TextStyle(
                    color: Palette.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'SERVICE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AddServicePage.routeName);
                },
                child: const Text(
                  'ADD SERVICE',
                  style: TextStyle(
                      color: Palette.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: _presenter!.services.length,
            itemBuilder: (context, index) {
              ServiceListItemBuilder builder = ServiceListItemBuilder();
              director.makeAdminCommentServiceItem(
                  builder: builder,
                  model: _presenter!.services[index],
                  onDelete: AdminCommentDeleteServiceCommand(
                      presenter: _presenter,
                      serviceModel: _presenter!.services[index]));
              return builder.createWidget();
            },
          ),
        ),
      ],
    );
  }

  @override
  void onLoadDataSucceeded() {
    if (mounted == false) {
      return;
    }
    setState(() {
      BarberSingleton singleton = BarberSingleton.getInstance();
      if (singleton.navigateFromOtherPage) {
        singleton.navigateFromOtherPage = false;
        _tabController.animateTo(1, duration: const Duration(milliseconds: 0));
      }
      barberName = _presenter!.getUserName();
      avatarUrl = _presenter!.getAvatarUrl();
      isLoading = false;
    });
  }

  @override
  void onPopContext() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void onWaitingProgressBar() {
    UtilWidgets.createLoadingWidget(context);
  }
}
