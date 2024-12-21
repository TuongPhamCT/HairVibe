import 'package:hairvibe/Builders/ModelBuilder/appointment_model_builder.dart';
import 'package:hairvibe/Contract/confirm_booking_contract.dart';
import 'package:hairvibe/Models/coupon_model.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Models/user_repo.dart';
import 'package:hairvibe/Singletons/appointment_singleton.dart';
import 'package:hairvibe/Singletons/booking_singleton.dart';

class ConfirmBookingPresenter {
  final ConfirmBookingContract _view;
  ConfirmBookingPresenter(this._view);

  final BookingSingleton _bookingSingleton = BookingSingleton.getInstance();
  final AppointmentSingleton _appointmentSingleton = AppointmentSingleton.getInstance();
  final UserRepository _userRepo = UserRepository();

  void handleAddVoucherPressed() {
    _view.onAddVoucher();
  }

  void handleRemoveVoucherPressed() {
    _view.onRemoveVoucher();
  }

  void onChangeDependencies() {
    _view.onChangeDependencies(true);
  }

  bool checkCacheVoucher() {
    CouponModel? coupon = _bookingSingleton.cacheCoupon;
    if (coupon != null) {
      _bookingSingleton.usedCoupon = coupon;
      _appointmentSingleton.setDiscount(coupon.discountRate!);
      return true;
    } else {
      return false;
    }
  }

  Future<void> handleConfirmBooking() async {
    _view.onWaitingProgressBar();

    if (_bookingSingleton.usedCoupon != null) {
      UserModel user = await _userRepo.getUserById(_bookingSingleton.customerID!);
      user.removeVoucherByID(_bookingSingleton.usedCoupon!.couponID!);
      await _userRepo.updateUser(user);
    }

    await _bookingSingleton.confirmAppointment();
    _bookingSingleton.resetCache();

    _view.onPopContext();
    _view.onConfirmBooking();
  }

}