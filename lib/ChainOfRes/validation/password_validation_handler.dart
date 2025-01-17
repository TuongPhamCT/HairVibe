import 'package:hairvibe/ChainOfRes/validation/validation_handler.dart';
import 'package:hairvibe/ChainOfRes/validation/validation_target.dart';

class PasswordValidationHandler extends ValidationHandler {
  @override
  void handle(ValidationTarget request) {
    if (request.containsKey(ValidationUniqueKey.PASSWORD)) {
      String password = request.getField(ValidationUniqueKey.PASSWORD);

      if (password.length < 8) {
        request.addErrorText(
            key: ValidationUniqueKey.PASSWORD,
            errorText: "Password must be at least 8 characters long"
        );
        request.errorMessage = "Password must be at least 8 characters long";
      } else {
        super.next?.handle(request);
      }

    } else {
      super.next?.handle(request);
    }
  }
}