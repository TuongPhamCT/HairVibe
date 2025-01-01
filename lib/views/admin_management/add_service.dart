import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/admin_management/comment.dart';

class AddServicePage extends StatefulWidget {
  const AddServicePage({super.key});
  static const String routeName = 'admin_add_service';

  @override
  _AddServicePageState createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AdminCommentPage()),
            );
          },
          child: Text(
            'CANCEL',
            style: TextDecor.leadingForgot.copyWith(color: Colors.amber),
          ),
        ),
        title: Text(
          'CREATE SERVICE',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Save action
            },
            child: Text(
              'SAVE',
              style: TextDecor.leadingForgot.copyWith(color: Colors.amber),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(nameController, 'Name'),
            _buildTextField(priceController, 'Price',
                keyboardType: TextInputType.number),
            _buildTextField(durationController, 'Duration'),
            _buildTextField(descriptionController, 'Description', maxLines: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String placeholder,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: TextDecor.serviceListItemTitle.copyWith(color: Colors.white),
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextDecor.serviceListItemTime.copyWith(color: Colors.grey),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
