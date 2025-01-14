import 'package:hairvibe/Builders/WidgetBuilder/check_service_list_item_builder.dart';
import 'package:hairvibe/Builders/WidgetBuilder/service_list_item_builder.dart';
import 'package:hairvibe/commands/command_interface.dart';

import '../../Models/service_model.dart';

class CustomizedWidgetBuilderDirector {

  void makePressableServiceItem({
    required ServiceListItemBuilder builder,
    required ServiceModel model,
    required CommandInterface? onPressed,
  }) {
    builder.reset();
    builder.setService(model);
    builder.setOnPressed(onPressed);
  }

  void makeAdminCommentServiceItem({
    required ServiceListItemBuilder builder,
    required ServiceModel model,
    required CommandInterface? onDelete,
  }) {
    builder.reset();
    builder.setService(model);
    builder.setDeletable(true);
    builder.setOnDelete(onDelete);
  }

}