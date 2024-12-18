import 'package:firebase_auth/firebase_auth.dart';
import 'package:hairvibe/Contract/coupon_tab_contract.dart';
import 'package:hairvibe/Models/coupon_repo.dart';

import '../Models/coupon_model.dart';

class CouponTabPresenter {
  final CouponTabContract? _view;

  CouponTabPresenter(this._view);
  final CouponRepository _couponRepo = CouponRepository();

  

}