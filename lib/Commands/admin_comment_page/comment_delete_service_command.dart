import 'package:hairvibe/Presenter/admin_comment_page_presenter.dart';
import 'package:hairvibe/commands/command_interface.dart';

import '../../Models/service_model.dart';

class AdminCommentDeleteServiceCommand implements CommandInterface {
  AdminCommentPagePresenter? presenter;
  ServiceModel serviceModel;

  AdminCommentDeleteServiceCommand({
    required this.presenter,
    required this.serviceModel
  });

  @override
  void execute() {
    presenter?.handleDeleteService(serviceModel);
  }
}