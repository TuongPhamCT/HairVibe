import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/views/admin_management/add_service.dart';
import 'package:hairvibe/widgets/admin_bottom_bar.dart';

class AdminCommentPage extends StatefulWidget {
  const AdminCommentPage({super.key});
  static const String routeName = 'admin_comment';

  @override
  _AdminCommentPageState createState() => _AdminCommentPageState();
}

class _AdminCommentPageState extends State<AdminCommentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final int _currentPageIndex = 3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: Text(
          'COMMENTS',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          // Add any actions if needed
        ],
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
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
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(AssetHelper.logo),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Text(
            'Barber Name',
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
          Expanded(
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
      bottomNavigationBar: AdminBottomBar(currentIndex: _currentPageIndex),
    );
  }

  Widget _buildReviews() {
    return ListView.builder(
      itemCount: 3, // Example count
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
          ),
          title: Text('Reviewer $index',
              style: TextDecor.homeTitle.copyWith(color: Colors.white)),
          subtitle: Text('This is a review text for reviewer $index.',
              style: TextStyle(color: Colors.white)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
                5, (starIndex) => Icon(Icons.star, color: Palette.primary)),
          ),
        );
      },
    );
  }

  Widget _buildServices() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'There is no service',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddServicePage()),
              );
            },
            child: Text(
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
}
