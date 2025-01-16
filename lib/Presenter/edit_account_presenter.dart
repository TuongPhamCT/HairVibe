import 'dart:io';
import 'package:hairvibe/Contract/edit_account_contract.dart';
import 'package:hairvibe/Facades/image_storage_facade.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Singletons/user_singleton.dart';
import 'package:hairvibe/facades/authenticator_facade.dart';
import 'package:image_picker/image_picker.dart';

class EditAccountPresenter {
  final EditAccountContract _view;
  EditAccountPresenter(this._view);

  final UserRepository _userRepo = UserRepository();
  final AuthenticatorFacade _auth = AuthenticatorFacade();
  final ImageStorageFacade _imageStorageFacade = ImageStorageFacade();

  UserModel? _model;
  File? tempAvatar;

  String? _validateName(String? name) {
    if (name!.isNotEmpty){
      return null;
    }
    return "Required";
  }

  String? _validatePhoneNumber(String? phone) {
    if (phone!.isNotEmpty){
      return null;
    }
    return "Required";
  }

  String? _validatePassword(String? password) {
    if (password!.length >= 8){
      return null;
    }
    return "Password must be at least 8 characters long.";
  }

  Future<void> getUserData() async {
    _model = await _userRepo.getUserById(_auth.userId!);
    _view.onLoadDataSucceed(_model!);
  }

  Future<void> updateAccount(
      String name,
      String phone,
      String password,
      ) async {

    name = name.trim();

    Map<String, String?> errorTexts = {};
    // Validating
    errorTexts["name"] = _validateName(name);
    errorTexts["phoneNumber"] = _validatePhoneNumber(phone);
    if (password.isNotEmpty) {
      errorTexts["password"] = _validatePassword(password);
    } else {
      errorTexts["password"] = null;
    }

    for (String? value in errorTexts.values){
      if (value != null){
        _view.onValidatingFailed(errorTexts);
        return;
      }
    }

    _model!.name = name;
    _model!.phoneNumber = phone;

    _view.onWaitingProgressBar();

    // Change password
    bool result = true;

    if (password.isNotEmpty) {
      result = await _auth.changePassword(password);
    }

    // change avatar
    if (result && tempAvatar != null) {
      String? path = await _imageStorageFacade.uploadImage(StorageFolderNames.BARBER_IMAGES, tempAvatar!);
      if (path != null) {
        _model?.image = path;
      } else {
        result = false;
      }
    }

    if (result) {
      result = await _userRepo.updateUser(_model!);
      UserSingleton.getInstance().setCurrentUser(_model!);
    }


    _view.onPopContext();

    if (result == true) {
      _view.onEditSucceeded();
    } else {
      _view.onEditFailed();
    }
    return;
  }

  Future<void> handleEditAvatar() async {
    XFile? pickedFile = await _imageStorageFacade.pickImage();

    if (pickedFile != null) {
      tempAvatar = File(pickedFile.path);
      _view.onChangeAvatar();
    }
  }
}