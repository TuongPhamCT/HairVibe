import 'package:get/get.dart';

class ValidationTarget {
  Map<String, dynamic> requiredFields = {};
  Map<String, String> errorTexts = {};
  String errorMessage = "";

  String? operator [](String key) => requiredFields[key];

  void operator []=(String key, String value) {
    requiredFields[key] = value;
  }

  void addField({
    required String key,
    required dynamic value
  }) {
    requiredFields[key] = value;
  }

  void removeField(String key) {
    requiredFields.remove(key);
  }

  String addPasswordField(String password) {
    return requiredFields[ValidationUniqueKey.PASSWORD] = password;
  }

  String addRePasswordField(String rePassword) {
    return requiredFields[ValidationUniqueKey.REPASSWORD] = rePassword;
  }

  String addEmailField(String email) {
    return requiredFields[ValidationUniqueKey.EMAIL] = email;
  }

  dynamic getField(String key) {
    if (requiredFields.containsKey(key)) {
      return requiredFields[key];
    } else {
      return null;
    }
  }

  bool containsKey(String key) {
    return requiredFields.containsKey(key);
  }

  bool isEmpty() {
    return requiredFields.isEmpty;
  }

  bool isNotEmpty() {
    return requiredFields.isNotEmpty;
  }

  // Error text
  bool isValid() {
    return errorTexts.isEmpty;
  }

  void addErrorText({
    required String key,
    required String errorText
  }) {
    errorTexts[key] = errorText;
  }

  String getErrorText(String key) {
    if (errorTexts.containsKey(key)) {
      return errorTexts[key] ?? "";
    }
    return "";
  }
}

abstract class ValidationUniqueKey {
  static const PASSWORD = "password";
  static const REPASSWORD = "rePassword";
  static const EMAIL = "email";
}