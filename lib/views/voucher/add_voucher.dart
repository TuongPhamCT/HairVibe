import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/Theme/palette.dart';

class AddVoucherPage extends StatelessWidget {
  final TextEditingController couponIDController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController discountRateController = TextEditingController();
  final TextEditingController infoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () {
            // cancel
          },
          child: Text(
            'CANCEL',
            style: TextDecor.leadingForgot.copyWith(color: Colors.amber),
          ),
        ),
        title: Text(
          'CREATE VOUCHER',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // save
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
            _buildTextField('Coupon ID', couponIDController),
            SizedBox(height: 16),
            _buildTextField('Title', titleController),
            SizedBox(height: 16),
            _buildTextField('Discount Rate', discountRateController),
            SizedBox(height: 16),
            _buildTextField('Info', infoController),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: TextDecor.inputText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextDecor.hintText,
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.primary),
        ),
      ),
    );
  }
}
