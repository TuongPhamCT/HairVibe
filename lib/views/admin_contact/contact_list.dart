import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';

class AdminContactListPage extends StatefulWidget {
  @override
  _AdminContactListPageState createState() => _AdminContactListPageState();
}

class _AdminContactListPageState extends State<AdminContactListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String userData = '''
A|John Doe
B|Alice Smith
''';

  String barberData = '''
A|Barber Joe
B|Barber Anna
''';

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
        title: TabBar(
          controller: _tabController,
          indicatorColor: Palette.primary,
          tabs: [
            Tab(text: 'USER'),
            Tab(text: 'BARBER'),
          ],
          labelStyle: TextDecor.homeTitle,
          unselectedLabelColor: Colors.white.withOpacity(0.6),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 14),
                IconButton(
                  icon: CircleAvatar(
                    backgroundColor: Palette.primary,
                    child: Icon(Icons.filter_alt, color: Colors.black),
                  ),
                  onPressed: () {
                    // Filter action
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Palette.primary,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Booking'),
          BottomNavigationBarItem(icon: Icon(Icons.email), label: 'Contact'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Palette.primary,
              child: Text('D', style: TextStyle(color: Colors.black)),
            ),
            label: 'Menu',
          ),
        ],
      ),
    );
  }

  Widget _buildList(String data) {
    List<String> lines = data.trim().split('\n');
    Map<String, List<Map<String, String>>> groupedData = {};

    for (String line in lines) {
      List<String> parts = line.split('|');
      String group = parts[0];
      String name = parts[1];

      if (!groupedData.containsKey(group)) {
        groupedData[group] = [];
      }
      groupedData[group]!.add({'name': name});
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
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(AssetHelper.logo,
                        width: 50, height: 50, fit: BoxFit.cover),
                  ),
                  title: Text(item['name']!,
                      style: TextDecor.homeTitle.copyWith(color: Colors.white)),
                ),
              );
            }).toList(),
          ],
        );
      }).toList(),
    );
  }
}
