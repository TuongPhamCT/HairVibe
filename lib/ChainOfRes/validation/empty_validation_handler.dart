import 'package:hairvibe/ChainOfRes/validation/validation_handler.dart';
import 'package:hairvibe/ChainOfRes/validation/validation_target.dart';

class EmptyValidationHandler extends ValidationHandler {
  @override
  void handle(ValidationTarget request) {
    for (String key in request.requiredFields.keys) {
      String value = request.getField(key).toString();
      if (value.isEmpty) {
        request.addErrorText(key: key, errorText: "Required");
      }
    }

    if (request.isValid()) {
      super.next?.handle(request);
    } else {
      request.errorMessage = "Please complete all required fields";
    }
  }
}