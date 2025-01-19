import 'package:hairvibe/ChainOfRes/validation/validation_handler.dart';
import 'package:hairvibe/ChainOfRes/validation/validation_target.dart';
import 'package:string_validator/string_validator.dart';

class EmailValidationHandler extends ValidationHandler {
  @override
  void handle(ValidationTarget request) {
    if (request.containsKey(ValidationUniqueKey.EMAIL)) {

      String email = request.getField(ValidationUniqueKey.EMAIL);

      if (email.isEmpty) {
        request.addErrorText(
            key: ValidationUniqueKey.EMAIL,
            errorText: "Please enter your email!"
        );
        request.errorMessage = "Please enter your email!";
        return;
      } else if (!isEmail(email)) {
        request.addErrorText(
            key: ValidationUniqueKey.EMAIL,
            errorText:  "Email is not in the correct format!",
        );
        request.errorMessage = "Email is not in the correct format!";
        return;
      }
    }

    super.next?.handle(request);
  }
}