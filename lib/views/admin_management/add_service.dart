import 'package:flutter/material.dart';
import 'package:hairvibe/Presenter/add_service_page_presenter.dart';
import 'package:hairvibe/Singletons/barber_singleton.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/views/admin_management/comment.dart';
import 'package:hairvibe/widgets/util_widgets.dart';

import '../../Contract/add_service_page_contract.dart';

class AddServicePage extends StatefulWidget {
  const AddServicePage({
    super.key,
  });
  static const String routeName = 'admin_add_service';

  @override
  AddServicePageState createState() => AddServicePageState();
}

class AddServicePageState extends State<AddServicePage> implements AddServicePageContract {
  AddServicePagePresenter? _presenter;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    _presenter = AddServicePagePresenter(this);
    super.initState();
  }

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
            onBack();
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
              _presenter?.handleCreateService(
                  name: nameController.text.trim(),
                  price: priceController.text.trim(),
                  duration: durationController.text.trim(),
                  description: descriptionController.text.trim()
              );
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
            _buildDurationPicker(),
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

  Widget _buildDurationPicker() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: durationController,
        keyboardType: TextInputType.text,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        readOnly: true,
        onTap: _showDurationPicker,
        style: TextDecor.serviceListItemTitle.copyWith(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Duration (minutes)",
          hintStyle: TextDecor.serviceListItemTime.copyWith(color: Colors.grey),
          border: InputBorder.none,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  void _showDurationPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Palette.primary,
      builder: (context) {
        return ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("${(index + 1) * 30} minutes"),
              onTap: () {
                setState(() {
                  durationController.text = "${(index + 1) * 30}";
                });
                Navigator.pop(context); // Đóng bottom sheet
              },
            );
          }
        );
      },
    );
  }

  @override
  void onCreateFailed(String message) {
    UtilWidgets.createSnackBar(context, message);
  }

  @override
  void onCreateSucceeded() {
    UtilWidgets.createDialog(
        context,
        UtilWidgets.NOTIFICATION,
        "Add new service successfully!",
        () {
          Navigator.of(context, rootNavigator: true).pop();
          onBack();
        }
    );
  }

  @override
  void onBack() {
    BarberSingleton singleton = BarberSingleton.getInstance();
    singleton.navigateFromOtherPage = true;
    Navigator.of(context).pushNamed(AdminCommentPage.routeName);
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
