import 'package:hairvibe/Contract/voucher_redeem_contract.dart';
import 'package:hairvibe/Facades/authenticator_facade.dart';
import 'package:hairvibe/Models/coupon_model.dart';
import 'package:hairvibe/Models/coupon_repo.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Singletons/appointment_singleton.dart';
import 'package:hairvibe/Singletons/booking_singleton.dart';

import '../Models/user_model.dart';

class VoucherRedeemPresenter {
  final VoucherRedeemContract _view;
  VoucherRedeemPresenter(this._view);

  final AuthenticatorFacade _auth = AuthenticatorFacade();
  final CouponRepository _couponRepo = CouponRepository();
  final UserRepository _userRepo = UserRepository();

  final AppointmentSingleton _appointmentSingleton = AppointmentSingleton.getInstance();
  final BookingSingleton _bookingSingleton = BookingSingleton.getInstance();

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
    _bookingSingleton.setCoupon(coupon);
    _view.onUseVoucher();
  }

  void handleRedeemCode(String code) {
    CouponModel? coupon = (coupons as List<CouponModel?>).firstWhere((item) => item!.couponID == code, orElse: () => null);
    if (coupon == null) {
      _view.onRedeemFailed("Voucher code doesn't exist");
    } else {
      _bookingSingleton.setCoupon(coupon);
      _appointmentSingleton.setDiscount(coupon.discountRate!);
      _view.onLoadDataSucceed();
    }
  }
}