import 'package:firebase_auth/firebase_auth.dart';
import 'package:hairvibe/Contract/sign_in_tab_contract.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/facades/AuthenticatorFacade.dart';

import '../Models/user_model.dart';

class SignInTabPresenter {
  final SignInTabContract _view;

  SignInTabPresenter(this._view);
  final AuthenticatorFacade _auth = AuthenticatorFacade();
  final UserRepository _userRepo = UserRepository();

  Future<void> login(String email, String password) async {
    try {
      _view.onWaitingProgressBar();
      await _auth.signInWithEmailAndPassword(email, password);
      //UserCredential userCredential = await _auth.signInWithEmailAndPassword(email, password);
      //UserModel userData = await _userRepo.getUserById(userCredential.user!.uid);
      //_prefService.saveUserData(userData);
    } on FirebaseAuthException catch (e) {
      _view.onPopContext();
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        _view.onInvalidEmailOrPassword();
      } else {
        _view.onLoginFailed();
      }
    } catch (e) {
      _view.onLoginFailed();
      return;
    }
    _view.onPopContext();
    _view.onLoginSucceeded();
  }
}