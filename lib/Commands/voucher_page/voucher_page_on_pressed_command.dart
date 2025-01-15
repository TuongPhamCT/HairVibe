import '../../Models/coupon_model.dart';
import '../../Presenter/voucher_page_presenter.dart';
import '../command_interface.dart';

class VoucherPageOnPressedCommand implements CommandInterface {
  VoucherPagePresenter? presenter;
  CouponModel? model;

  VoucherPageOnPressedCommand({
    required this.presenter,
    required this.model
  });

  @override
  void execute() {
    presenter?.handleUseVoucher(model!);
  }

}