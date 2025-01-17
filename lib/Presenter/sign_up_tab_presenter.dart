import 'package:firebase_auth/firebase_auth.dart';
import 'package:hairvibe/ChainOfRes/validation/email_validation_handler.dart';
import 'package:hairvibe/ChainOfRes/validation/empty_validation_handler.dart';
import 'package:hairvibe/ChainOfRes/validation/validation_target.dart';
import 'package:hairvibe/Const/app_config.dart';
import 'package:hairvibe/Contract/sign_up_tab_contract.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/facades/authenticator_facade.dart';
import 'package:string_validator/string_validator.dart';

import '../ChainOfRes/validation/password_validation_handler.dart';
import '../ChainOfRes/validation/repassword_validation_handler.dart';

class SignUpTabPresenter {
  final SignUpTabContract _view;
  final AuthenticatorFacade _auth = AuthenticatorFacade();
  final UserRepository _userRepo = UserRepository(AppConfig.dbType);

  final EmptyValidationHandler validator1 = EmptyValidationHandler();
  final EmailValidationHandler validator2 = EmailValidationHandler();
  final PasswordValidationHandler validator3 = PasswordValidationHandler();
  final RePasswordValidationHandler validator4 = RePasswordValidationHandler();

  SignUpTabPresenter(this._view) {
    validator1.setNext(validator2);
    validator2.setNext(validator3);
    validator3.setNext(validator4);
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

    // Validating
    ValidationTarget validationTarget = ValidationTarget();
    validationTarget.addEmailField(email);
    validationTarget.addField(key: "name", value: name);
    validationTarget.addField(key: "phoneNumber", value: phone);
    validationTarget.addPasswordField(password);
    validationTarget.addRePasswordField(confirmPassword);

    validator1.handle(validationTarget);

    if (validationTarget.isValid() == false){
      _view.onValidatingFailed(validationTarget);
    }


    // Sign Up email
    _view.onWaitingProgressBar();
    bool? result = await _auth.checkIfEmailExists(email);

    if (result == true) {
      _view.onPopContext();
      _view.onEmailAlreadyInUse();
    } else if (result == false) {
      UserCredential? userData = await _auth.signUpWithEmailAndPassword(email, password);
      if (userData == null){
        _view.onPopContext();
        _view.onSignUpFailed();
        return;
      }
      UserModel model = UserModel(
          userID: userData.user!.uid,
          email: email,
          name: name,
          phoneNumber: phone,
          userType: UserType.CUSTOMER
      );
      await _userRepo.addUser(model);
      _view.onPopContext();
      _view.onSignUpSucceeded();
    } else if (result == null) {
      _view.onPopContext();
      _view.onSignUpFailed();
    }
    return;
  }
}
