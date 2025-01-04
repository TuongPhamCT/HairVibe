import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hairvibe/Models/coupon_model.dart';

class CouponRepository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;

  void addCouponToFirestore(CouponModel model) async {
    try {
      DocumentReference docRef = _storage.collection(CouponModel.collectionName).doc(model.couponID);
      await docRef.set(model.toJson()).whenComplete(()
        => print('Coupon added to Firestore with ID: ${docRef.id}'));
    } catch (e) {
      print('Error adding Coupon to Firestore: $e');
    }
  }

  Future<bool> updateCoupon(CouponModel model) async {
    bool isSuccess = false;

    await _storage.collection(CouponModel.collectionName)
        .doc(model.couponID)
        .update(model.toJson())
        .then((_) => isSuccess = true);

    return isSuccess;
  }

  void deleteCouponById(String id) async => _storage.collection(CouponModel.collectionName).doc(id).delete();

  Future<CouponModel?> getCouponById(String id) async {
    try {
      final DocumentReference<Map<String, dynamic>> collectionRef = _storage.collection(CouponModel.collectionName).doc(id);
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await collectionRef.get();

      final CouponModel coupon = CouponModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      return coupon;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<CouponModel>> getAllCoupons(String id) async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(CouponModel.collectionName).get();
      final coupons = querySnapshot
          .docs
          .map((doc) => CouponModel.fromJson(doc as Map<String, dynamic>))
          .toList();
      return coupons;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<CouponModel>> getCouponsByIdList (List<String> couponIdList) async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(CouponModel.collectionName)
          .where('couponID', whereIn: couponIdList).get();
      final coupons = querySnapshot
          .docs
          .map((doc) => CouponModel.fromJson(doc as Map<String, dynamic>))
          .toList();
      return coupons;
    } catch (e) {
      print(e);
      return [];
    }
  }
}