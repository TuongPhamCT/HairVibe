import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';
import 'package:hairvibe/widgets/barber_bottom_bar.dart';

class BarberContactList extends StatefulWidget {
  @override
  _BarberContactListState createState() => _BarberContactListState();
}

class _BarberContactListState extends State<BarberContactList> {
  String userData = '''
A|John Doe
B|Alice Smith
''';

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
            child: _buildList(userData),
          ),
        ],
      ),
      bottomNavigationBar: BarberBottomNavigationBar(),
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
