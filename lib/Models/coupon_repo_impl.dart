import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/coupon_model.dart';

abstract class CouponRepoImplInterface {
  Future<void> addCoupon(CouponModel model);

  Future<bool> updateCoupon(CouponModel model);

  Future<void> deleteCouponById(String id);

  Future<CouponModel?> getCouponById(String id);

  Future<List<CouponModel>> getAllCoupons(String id);

  Future<List<CouponModel>> getCouponsByIdList (List<String> couponIdList);
}