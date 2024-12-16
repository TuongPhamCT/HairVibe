import 'package:flutter/cupertino.dart';
import 'package:hairvibe/Builders/WidgetBuilder/widget_builder.dart';
import '../../Models/service_model.dart';
import '../../Utility.dart';
import '../../widgets/list_view/service_list_item.dart';

class ServiceListItemBuilder implements CustomizedWidgetBuilder {
  ServiceModel? service;
  VoidCallback? onPressed;

  void setService(ServiceModel service){
    this.service = service;
  }

  void setOnPressed(VoidCallback onPressed){
    this.onPressed = onPressed;
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
    );
  }

  @override
  void reset() {
    service = null;
    onPressed = null;
  }
}