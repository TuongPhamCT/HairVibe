import 'package:hairvibe/Const/app_config.dart';
import 'package:hairvibe/Contract/voucher_page_contract.dart';
import 'package:hairvibe/Facades/authenticator_facade.dart';
import 'package:hairvibe/Models/coupon_model.dart';
import 'package:hairvibe/Models/coupon_repo.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Singletons/booking_singleton.dart';

import '../Models/user_model.dart';

class VoucherPagePresenter {
  final VoucherPageContract _view;
  VoucherPagePresenter(this._view);

  final AuthenticatorFacade _auth = AuthenticatorFacade();
  final CouponRepository _couponRepo = CouponRepository(AppConfig.dbType);
  final UserRepository _userRepo = UserRepository(AppConfig.dbType);
  final BookingSingleton _bookingSingleton = BookingSingleton();

  List<CouponModel> coupons = [];

  Future<void> getData() async {
    UserModel user = await _userRepo.getUserById(_auth.userId!);
    List<String> couponList = user.getVoucherIDs();
    if (couponList.isNotEmpty) {
      coupons = await _couponRepo.getCouponsByIdList(couponList);
    }
    _view.onLoadDataSucceed();
  }

  void handleUseVoucher(CouponModel coupon) {
    _bookingSingleton.setCacheCoupon(coupon);
    _view.onUseVoucher();
  }
}