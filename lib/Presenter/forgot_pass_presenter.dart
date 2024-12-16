import 'package:hairvibe/Contract/forgot_pass_contract.dart';
import '../facades/authenticator_facade.dart';

class ForgotPassScreenPresenter {
  final ForgotPassScreenContract _view;
  final AuthenticatorFacade _auth = AuthenticatorFacade();
  ForgotPassScreenPresenter(this._view);

  Future<void> resetPassword(String email) async {
    email = email.trim();

    // Validate Email
    _view.onWaitingProgressBar();
    bool? result = await _auth.checkIfEmailExists(email);
    _view.onPopContext();

    if (result == true) {
      _view.onEmailNotFound();
    } else if (result == false) {
      bool result = await _auth.sendPasswordResetEmail(email);
      if (result){
        _view.onResetSucceeded();
      } else {
        _view.onResetFailed();
      }
    } else if (result == null) {
      _view.onResetFailed();
    }
  }
}