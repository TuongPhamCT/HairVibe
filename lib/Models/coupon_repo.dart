import 'package:hairvibe/Models/coupon_model.dart';
import 'package:hairvibe/Models/coupon_repo_impl.dart';

import '../Const/database_config.dart';
import 'firebase/firebase_coupon_repo.dart';

class CouponRepository {
  late CouponRepoImplInterface _impl;

  CouponRepository(String dbType) {
    switch (dbType) {
      case DatabaseConfig.FIREBASE:
        _impl = FirebaseCouponRepoImpl();
        break;
      case DatabaseConfig.MONGO_DB:
        _impl = MongoDBCouponRepoImpl();
    }
  }

  Future<void> addCouponToFirestore(CouponModel model) async {
    return await _impl.addCoupon(model);
  }

  Future<bool> updateCoupon(CouponModel model) async {
    return await _impl.updateCoupon(model);
  }

  void deleteCouponById(String id) async {
    return await _impl.deleteCouponById(id);
  }

  Future<CouponModel?> getCouponById(String id) async {
    return await _impl.getCouponById(id);
  }

  Future<List<CouponModel>> getAllCoupons(String id) async {
    return await _impl.getAllCoupons(id);
  }

  Future<List<CouponModel>> getCouponsByIdList (List<String> couponIdList) async {
    return await _impl.getCouponsByIdList(couponIdList);
  }
}