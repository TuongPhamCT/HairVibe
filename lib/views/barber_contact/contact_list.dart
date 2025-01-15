import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/widgets/barber_bottom_bar.dart';
import 'package:hairvibe/Contract/barber_contact_list_contract.dart';
import 'package:hairvibe/Presenter/barber_contact_list_presenter.dart';
import 'package:hairvibe/Models/user_model.dart';

class BarberContactList extends StatefulWidget {
  const BarberContactList({super.key});
  static const routeName = 'barber_contact';

  @override
  BarberContactListState createState() => BarberContactListState();
}

class BarberContactListState extends State<BarberContactList>
    with SingleTickerProviderStateMixin
    implements BarberContactListPageContract {
  BarberContactListPagePresenter? _presenter;
  //late TabController _tabController;
  final int _currentPageIndex = 2;
  final TextEditingController _searchController = TextEditingController();

  bool isLoading = true;
  bool isSearching = false;

  List<ContactListData> userData = [];

  @override
  void initState() {
    super.initState();
    _presenter = BarberContactListPagePresenter(this);
  }

  @override
  void dispose() {
    //_tabController.dispose();
    super.dispose();
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
        centerTitle: true,
        title: Text('CONTACT', style: TextDecor.homeTitle),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
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
                    onSubmitted: (text) {
                      isSearching = text.isNotEmpty;
                      _presenter?.handleSearch(text.trim());
                    },
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
            child: _buildList(userData),
          ),
        ],
      ),
      bottomNavigationBar:
          BarberBottomNavigationBar(currentIndex: _currentPageIndex),
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
            }).toList(),
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
    });
  }

  @override
  void onSearch(List<UserModel> customerResults) {
    setState(() {
      userData = customerResults
          .map((element) => ContactListData(user: element, onPress: () {}))
          .toList();
    });
  }
}

class ContactListData {
  final UserModel user;
  final VoidCallback onPress;

  ContactListData({required this.user, required this.onPress});
}
