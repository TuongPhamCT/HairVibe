import 'package:mongo_dart/mongo_dart.dart';
import 'package:hairvibe/Models/coupon_model.dart';

class MongoDBCouponRepoImplementation {
  final Db _db = Db(
      'mongodb://localhost:27017/hairvibe'); // Replace with your MongoDB connection string
  final String collectionName = CouponModel.collectionName;

  Future<void> addCouponToMongo(CouponModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      await collection.insertOne(model.toJson());
      print('Coupon added to MongoDB with ID: ${model.couponID}');
    } catch (e) {
      print('Error adding Coupon to MongoDB: $e');
    } finally {
      await _db.close();
    }
  }

  Future<bool> updateCoupon(CouponModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final result = await collection.updateOne(
        where.eq('couponID', model.couponID),
        modify.set('data', model.toJson()),
      );
      return result.isSuccess;
    } catch (e) {
      print('Error updating Coupon in MongoDB: $e');
      return false;
    } finally {
      await _db.close();
    }
  }

  Future<void> deleteCouponById(String id) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      await collection.deleteOne(where.eq('couponID', id));
      print('Coupon deleted from MongoDB with ID: $id');
    } catch (e) {
      print('Error deleting Coupon from MongoDB: $e');
    } finally {
      await _db.close();
    }
  }

  Future<CouponModel?> getCouponById(String id) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final result = await collection.findOne(where.eq('couponID', id));
      return result != null ? CouponModel.fromJson(result) : null;
    } catch (e) {
      print('Error fetching Coupon from MongoDB: $e');
      return null;
    } finally {
      await _db.close();
    }
  }

  Future<List<CouponModel>> getAllCoupons() async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final results = await collection.find().toList();
      return results.map((json) => CouponModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching all Coupons from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }

  Future<List<CouponModel>> getCouponsByIdList(
      List<String> couponIdList) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
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
