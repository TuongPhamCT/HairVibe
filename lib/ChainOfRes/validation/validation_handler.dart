import 'package:hairvibe/ChainOfRes/handler_interface.dart';
import 'package:hairvibe/ChainOfRes/validation/validation_target.dart';

class ValidationHandler implements HandlerInterface<ValidationTarget> {
  HandlerInterface? next;

  @override
  void setNext(HandlerInterface handler) {
    next = handler;
  }

  @override
  void handle(ValidationTarget request) {
    next?.handle(request);
  }
}