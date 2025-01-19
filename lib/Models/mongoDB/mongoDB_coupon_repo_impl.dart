import 'package:mongo_dart/mongo_dart.dart';
import 'package:hairvibe/Models/coupon_model.dart';
import 'package:hairvibe/Models/coupon_repo_impl.dart';

class MongoDBCouponRepoImpl implements CouponRepoImplInterface {
  final Db _db = Db(
      'mongodb://localhost:27017/hairvibe'); // Replace with your MongoDB connection string

  @override
  Future<void> addCoupon(CouponModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(CouponModel.collectionName);
      await collection.insert(model.toJson());
      print('Coupon added to MongoDB with ID: ${model.couponID}');
    } catch (e) {
      print('Error adding Coupon to MongoDB: $e');
    } finally {
      await _db.close();
    }
  }

  @override
  Future<bool> updateCoupon(CouponModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(CouponModel.collectionName);
      final result = await collection.update(
        where.eq('couponID', model.couponID),
        model.toJson(),
      );
      return result['n'] > 0; // Check if any document was updated
    } catch (e) {
      print('Error updating Coupon in MongoDB: $e');
      return false;
    } finally {
      await _db.close();
    }
  }

  @override
  Future<void> deleteCouponById(String id) async {
    try {
      await _db.open();
      final collection = _db.collection(CouponModel.collectionName);
      await collection.remove(where.eq('couponID', id));
      print('Coupon deleted from MongoDB with ID: $id');
    } catch (e) {
      print('Error deleting Coupon from MongoDB: $e');
    } finally {
      await _db.close();
    }
  }

  @override
  Future<CouponModel?> getCouponById(String id) async {
    try {
      await _db.open();
      final collection = _db.collection(CouponModel.collectionName);
      final result = await collection.findOne(where.eq('couponID', id));
      return result != null ? CouponModel.fromJson(result) : null;
    } catch (e) {
      print('Error fetching Coupon by ID from MongoDB: $e');
      return null;
    } finally {
      await _db.close();
    }
  }

  @override
  Future<List<CouponModel>> getAllCoupons(String id) async {
    try {
      await _db.open();
      final collection = _db.collection(CouponModel.collectionName);
      final results = await collection.find().toList();
      return results.map((json) => CouponModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching all Coupons from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }

  @override
  Future<List<CouponModel>> getCouponsByIdList(
      List<String> couponIdList) async {
    try {
      await _db.open();
      final collection = _db.collection(CouponModel.collectionName);
      final results = await collection
          .find(where.oneFrom('couponID', couponIdList))
          .toList();
      return results.map((json) => CouponModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching Coupons by ID list from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }
}
