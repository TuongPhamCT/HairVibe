import 'package:mongo_dart/mongo_dart.dart';
import 'package:hairvibe/Models/user_model.dart';

class MongoDBUserRepoImplementation {
  final Db _db = Db(
      'mongodb://localhost:27017/hairvibe'); // Replace with your MongoDB connection string
  final String collectionName = UserModel.collectionName;

  Future<void> addUserToMongo(UserModel user) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      await collection.insertOne(user.toJson());
      print('User added to MongoDB with ID: ${user.userID}');
    } catch (e) {
      print('Error adding user to MongoDB: $e');
    } finally {
      await _db.close();
    }
  }

  Future<bool> updateUser(UserModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final result = await collection.updateOne(
        where.eq('_id', model.userID),
        modify.set('data', model.toJson()),
      );
      return result.isSuccess;
    } catch (e) {
      print('Error updating user in MongoDB: $e');
      return false;
    } finally {
      await _db.close();
    }
  }

  Future<UserModel?> getUserById(String id) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final result = await collection.findOne(where.eq('_id', id));
      return result != null ? UserModel.fromJson(result) : null;
    } catch (e) {
      print('Error fetching user by ID from MongoDB: $e');
      return null;
    } finally {
      await _db.close();
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final results = await collection.find().toList();
      return results.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching all users from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }

  Future<List<UserModel>> getUsersByType(String userType) async {
    try {
      await _db.open();
      final collection = _db.collection(collectionName);
      final results =
          await collection.find(where.eq('userType', userType)).toList();
      return results.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching users by type from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }

  Future<int> getUsersCountByType(String userType) async {
    try {
      final users = await getUsersByType(userType);
      return users.length;
    } catch (e) {
      print('Error counting users by type from MongoDB: $e');
      return 0;
    }
  }

  Future<int> getBarbersCount() async => getUsersCountByType(UserType.BARBER);

  Future<int> getCustomersCount() async =>
      getUsersCountByType(UserType.CUSTOMER);
}
