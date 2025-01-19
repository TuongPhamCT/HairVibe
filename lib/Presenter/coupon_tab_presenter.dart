import 'package:hairvibe/Const/app_config.dart';
import 'package:hairvibe/Contract/coupon_tab_contract.dart';
import 'package:hairvibe/Models/coupon_repo.dart';


class CouponTabPresenter {
  final CouponTabContract? _view;

  CouponTabPresenter(this._view);
  final CouponRepository _couponRepo = CouponRepository(AppConfig.dbType);

  

}