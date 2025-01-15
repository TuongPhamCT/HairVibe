import 'package:flutter/src/widgets/framework.dart';
import 'package:hairvibe/Builders/WidgetBuilder/widget_builder.dart';
import 'package:hairvibe/Commands/command_interface.dart';
import 'package:hairvibe/Models/coupon_model.dart';
import 'package:hairvibe/widgets/list_view/voucher_item.dart';

class VoucherItemBuilder implements CustomizedWidgetBuilder {

  CouponModel? couponModel;
  CommandInterface? onPressed;

  void setCouponModel(CouponModel coupon) {
    couponModel = coupon;
  }

  void setOnPressed(CommandInterface onPressed) {
    this.onPressed = onPressed;
  }

  @override
  Widget? createWidget() {
    if (couponModel == null) {
      return null;
    }
    return VoucherItem(
      voucherName: couponModel!.title!,
      voucherCode: couponModel!.couponID!,
      discountRate: couponModel!.discountRate as String,
      onPressed: onPressed
    );
  }

  @override
  void reset() {
    couponModel = null;
    onPressed = null;
  }

}