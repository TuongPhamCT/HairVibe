import 'package:hairvibe/Commands/command_interface.dart';
import 'package:hairvibe/Models/coupon_model.dart';
import 'package:hairvibe/Presenter/voucher_redeem_presenter.dart';

class VoucherRedeemOnPressedCommand implements CommandInterface {
  VoucherRedeemPresenter? presenter;
  CouponModel? model;

  VoucherRedeemOnPressedCommand({
    required this.presenter,
    required this.model
  });

  @override
  void execute() {
    presenter?.handleUseVoucher(model!);
  }

}