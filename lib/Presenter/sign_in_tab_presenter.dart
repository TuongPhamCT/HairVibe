import 'package:firebase_auth/firebase_auth.dart';
import 'package:hairvibe/Const/app_config.dart';
import 'package:hairvibe/Contract/sign_in_tab_contract.dart';
import 'package:hairvibe/Facades/authenticator_facade.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Singletons/user_singleton.dart';
import 'package:hairvibe/Strategy/LoginStrategy/login_navigator_strategy.dart';

import '../Models/user_model.dart';

class SignInTabPresenter {
  final SignInTabContract _view;

  SignInTabPresenter(this._view);
  final AuthenticatorFacade _auth = AuthenticatorFacade();
  final UserRepository _userRepo = UserRepository(AppConfig.dbType);
  final UserSingleton _userSingleton = UserSingleton.getInstance();

  Future<void> login(String email, String password) async {
    _view.onWaitingProgressBar();
    //await _auth.signInWithEmailAndPassword(email, password);
    AuthError errorCatcher = AuthError();
    UserCredential? userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
          errorCatcher: errorCatcher
      );

    if (errorCatcher.errorCode != null) {
      _view.onPopContext();
      switch (errorCatcher.errorCode) {
        case AuthError.USER_NOT_FOUND:
          _view.onInvalidEmailOrPassword();
          break;
        case AuthError.WRONG_PASSWORD:
          _view.onInvalidEmailOrPassword();
          break;
        case AuthError.NETWORK_FAILED:
          _view.onLoginFailed();
          break;
        default:
          _view.onLoginFailed();
          break;
      }
      return;
    }

    if (userCredential == null) {
      _view.onPopContext();
      _view.onLoginFailed();
      return;
    }

    UserModel userData = await _userRepo.getUserById(userCredential.user!.uid);
    _userSingleton.setCurrentUser(userData);
    await _userSingleton.handleActionsAfterLogin();
    //_prefService.saveUserData(userData);
    _view.onPopContext();
    _view.onLoginSucceeded();
  }

  LoginNavigatorStrategy getLoginNavigatorStrategy() {
    if (_userSingleton.currentUserIsCustomer()) {
      return CustomerLoginNavigatorStrategy();
    } else if (_userSingleton.currentUserIsBarber()) {
      return BarberLoginNavigatorStrategy();
    } else {
      return AdminLoginNavigatorStrategy();
    }
  }
}