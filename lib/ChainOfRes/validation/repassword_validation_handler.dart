import 'package:hairvibe/ChainOfRes/validation/validation_handler.dart';
import 'package:hairvibe/ChainOfRes/validation/validation_target.dart';

class RePasswordValidationHandler extends ValidationHandler {
  @override
  void handle(ValidationTarget request) {
    if (
      request.containsKey(ValidationUniqueKey.PASSWORD)
      && request.containsKey(ValidationUniqueKey.REPASSWORD)
    ) {
      String password = request.getField(ValidationUniqueKey.PASSWORD);
      String rePassword = request.getField(ValidationUniqueKey.REPASSWORD);

      if (password != rePassword) {
        request.addErrorText(
            key: ValidationUniqueKey.REPASSWORD,
            errorText: "Passwords do not match"
        );
        request.errorMessage = "Passwords do not match";
      } else {
        super.next?.handle(request);
      }

    } else {
      super.next?.handle(request);
    }
  }
}