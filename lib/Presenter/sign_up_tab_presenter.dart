import 'package:firebase_auth/firebase_auth.dart';
import 'package:hairvibe/Contract/sign_up_tab_contract.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/facades/authenticator_facade.dart';
import 'package:string_validator/string_validator.dart';

class SignUpTabPresenter {
  final SignUpTabContract _view;
  final AuthenticatorFacade _auth = AuthenticatorFacade();
  final UserRepository _userRepo = UserRepository();

  SignUpTabPresenter(this._view);

  String? _validateEmail(String? email) {
    email = email?.trim();
    if (email == null || email.isEmpty) {
      return "Please enter your email!";
    } else if (!isEmail(email)) {
      return "Email is not in the correct format!";
    }
    return null;
  }

  String? _validateName(String? name) {
    if (name!.isNotEmpty) {
      return null;
    }
    return "Required";
  }

  String? _validatePhoneNumber(String? phone) {
    if (phone!.isNotEmpty) {
      return null;
    }
    return "Required";
  }

  String? _validatePassword(String? password) {
    if (password!.length >= 8) {
      return null;
    }
    return "Password must be at least 8 characters long.";
  }

  String? _validateConfirmPassword(String? password, String? confirmPassword) {
    if (password == confirmPassword) {
      return null;
    }
    return "Passwords do not match";
  }


  Future<void> signUp(
      String email,
      String name,
      String phone,
      String password,
      String confirmPassword
  ) async {
    email = email.trim();
    name = name.trim();

    Map<String, String?> errorTexts = {};
    // Validating
    errorTexts["email"] = _validateEmail(email);
    errorTexts["name"] = _validateName(name);
    errorTexts["phoneNumber"] = _validatePhoneNumber(phone);
    errorTexts["password"] = _validatePassword(password);
    errorTexts["confirmPassword"] =
        _validateConfirmPassword(password, confirmPassword);

    for (String? value in errorTexts.values){
      if (value != null){
        _view.onValidatingFailed(errorTexts);
      }
    }

    // Sign Up email
    _view.onWaitingProgressBar();
    bool? result = await _auth.checkIfEmailExists(email);
    _view.onPopContext();

    if (result == true) {
      _view.onEmailAlreadyInUse();
    } else if (result == false) {
      UserCredential? userData = await _auth.signUpWithEmailAndPassword(email, password);
      if (userData == null){
        _view.onSignUpFailed();
        return;
      }
      UserModel model = UserModel(
          userID: userData.user!.uid,
          email: email,
          name: name,
          phoneNumber: phone,
          userType: UserType.CUSTOMER);
      _userRepo.addUserToFirestore(model);
      _view.onSignUpSucceeded();
    } else if (result == null) {
      _view.onSignUpFailed();
    }
    return;
  }
}
