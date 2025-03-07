import 'package:flutter/material.dart';
import 'package:hairvibe/Contract/admin_contact_list_contract.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Presenter/admin_contact_list_presenter.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/views/all_barber/detail_barber.dart';
import 'package:hairvibe/widgets/admin_bottom_bar.dart';
import 'package:hairvibe/views/admin_contact/add_barber.dart';
import 'package:hairvibe/widgets/util_widgets.dart';

class AdminContactListPage extends StatefulWidget {
  final int? tabIndex;
  const AdminContactListPage({
    super.key,
    this.tabIndex
  });
  static const String routeName = 'admin_contact';

  @override
  AdminContactListPageState createState() => AdminContactListPageState();
}

class AdminContactListPageState extends State<AdminContactListPage>
    with SingleTickerProviderStateMixin
    implements AdminContactListPageContract {
  AdminContactListPagePresenter? _presenter;
  late TabController _tabController;
  final int _currentPageIndex = 2;
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = true;
  bool isSearching = false;

  List<ContactListData> userData = [];
  List<ContactListData> barberData = [];


  @override
  void initState() {
    super.initState();
    _presenter = AdminContactListPagePresenter(this);
    _tabController = TabController(length: 2, vsync: this);

    // Add a listener to update the UI when the tab changes
    _tabController.addListener(() {
      setState(() {
        // Debug print to check the current tab index
        print('Current Tab Index: ${_tabController.index}');
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.tabIndex != null) {
      _tabController.animateTo(1, duration: const Duration(milliseconds: 0));
    }
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
        automaticallyImplyLeading: false,
        title: TabBar(
          controller: _tabController,
          indicatorColor: Palette.primary,
          tabs: const [
            Tab(text: 'USER'),
            Tab(text: 'BARBER'),
          ],
          labelStyle: TextDecor.homeTitle,
          unselectedLabelColor: Colors.white.withOpacity(0.6),
        ),
      ),
      body: isLoading ? UtilWidgets.getLoadingWidget() : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    onSubmitted: (text) {
                      isSearching = text.isNotEmpty;
                      _presenter?.handleSearch(text.trim());
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                if (isSearching)
                  IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: Palette.primary,
                      child: Icon(Icons.backspace_rounded, color: Colors.black),
                    ),
                    onPressed: () {
                      _searchController.clear();
                      isSearching = false;
                      _presenter?.handleSearch("");
                    },
                  ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildList(userData),
                  _buildList(barberData),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AdminBottomBar(currentIndex: _currentPageIndex),
      floatingActionButton: _tabController.index == 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddBarberScreen()),
                );
              },
              backgroundColor: Palette.primary,
              child: const Icon(Icons.add, color: Colors.black),
            )
          : null,
    );
  }

  Widget _buildList(List<ContactListData> userList) {
    Map<String, List<ContactListData>> groupedData = {};

    for (ContactListData data in userList) {
      String header = data.user.name![0].toUpperCase();
      if (groupedData.containsKey(header) == false) {
        groupedData[header] = [];
      }
      groupedData[header]!.add(data);
    }

    return ListView(
      shrinkWrap: true,
      children: groupedData.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 8.0, 16.0, 8.0),
              child: Text(entry.key,
                  style: TextDecor.homeTitle.copyWith(color: Colors.white)),
            ),
            ...entry.value.map((item) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0, 16.0, 0),
                child: ListTile(
                  onTap: item.onPress,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: item.user.image == null || item.user.image!.isEmpty
                        ? Image.asset(AssetHelper.logo,
                            width: 50, height: 50, fit: BoxFit.cover)
                        : Image.network(item.user.image!,
                            width: 50, height: 50, fit: BoxFit.cover),
                  ),
                  title: Text(item.user.name!,
                      style: TextDecor.homeTitle.copyWith(color: Colors.white)),
                ),
              );
            }),
          ],
        );
      }).toList(),
    );
  }

  @override
  void onLoadDataSucceeded() {
    setState(() {
      userData = _presenter!.customers
          .map((element) => ContactListData(user: element, onPress: () {}))
          .toList();
      barberData = _presenter!.barbers
          .map((element) => ContactListData(
              user: element,
              onPress: () {
                _presenter!.handleBarberPressed(element);
              }))
          .toList();
      isLoading = false;
    });
  }

  @override
  void onSelectBarber() {
    Navigator.of(context).pushNamed(DetailBarber.routeName);
  }

  @override
  void onSearch(
      List<UserModel> customerResults, List<UserModel> barberResults) {
    setState(() {
      userData = customerResults
          .map((element) => ContactListData(user: element, onPress: () {}))
          .toList();

      barberData = barberResults
          .map((element) => ContactListData(
              user: element,
              onPress: () {
                _presenter!.handleBarberPressed(element);
              }))
          .toList();
    });
  }
}

class ContactListData {
  final UserModel user;
  final VoidCallback onPress;

  ContactListData({required this.user, required this.onPress});
}
