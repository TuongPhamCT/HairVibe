import 'package:flutter/cupertino.dart';
import 'package:hairvibe/Builders/WidgetBuilder/widget_builder.dart';
import 'package:hairvibe/Models/service_model.dart';
import 'package:hairvibe/Utility.dart';

import '../../widgets/list_view/check_service_list_item.dart';

class CheckServiceListItemBuilder implements CustomizedWidgetBuilder {
  ServiceModel? service;
  bool? isChecked;
  Function(bool newValue)? onChanged;

  void setService(ServiceModel model) {
    service = model;
  }

  void setIsChecked(bool value) {
    isChecked = value;
  }

  void setOnChanged(Function(bool newValue) onChanged) {
    this.onChanged = onChanged;
  }

  @override
  Widget? createWidget() {
    if (service == null){
      return null;
    }
    return CheckServiceListItem(
      title: service!.name!,
      isChecked: true,
      price: Utility.formatCurrency(service!.price),
      duration: Utility.formatDurationFromSeconds(service!.duration),
      onChanged: onChanged ?? (bool newValue) {},
    );
  }

  @override
  void reset() {
    service = null;
    isChecked = null;
    onChanged = null;
  }

}