import 'package:flutter/cupertino.dart';
import 'package:hairvibe/Builders/WidgetBuilder/widget_builder.dart';
import 'package:hairvibe/commands/command_interface.dart';
import '../../Models/service_model.dart';
import '../../Utility.dart';
import '../../widgets/list_view/service_list_item.dart';

class ServiceListItemBuilder implements CustomizedWidgetBuilder {
  ServiceModel? service;
  bool deletable = false;
  CommandInterface? onPressed;
  CommandInterface? onDelete;

  void setService(ServiceModel service){
    this.service = service;
  }

  void setOnPressed(CommandInterface? onPressed){
    this.onPressed = onPressed;
  }

  void setDeletable(bool value) {
    deletable = value;
  }

  void setOnDelete(CommandInterface? onDelete) {
    this.onDelete = onDelete;
  }

  @override
  Widget? createWidget() {
    if (service == null) {
      return null;
    }
    return ServiceListItem(
      serviceName: service!.name,
      duration: Utility.formatDurationFromSeconds(service!.duration),
      cost: Utility.formatCurrency(service!.price),
      onPressed: onPressed,
      deletable: deletable,
      onDelete: onDelete,
    );
  }

  @override
  void reset() {
    service = null;
    onPressed = null;
    onDelete = null;
    deletable = false;
  }
}