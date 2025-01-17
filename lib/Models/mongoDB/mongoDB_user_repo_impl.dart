import 'package:mongo_dart/mongo_dart.dart';
import 'package:hairvibe/Models/user_model.dart';
import 'package:hairvibe/Models/user_repo_impl.dart';
class MongoDBUserRepoImpl implements UserRepoImplInterface {
  final Db _db = Db(
      'mongodb://localhost:27017/hairvibe'); // Replace with your MongoDB connection string

 @override
  Future<void> addUser(UserModel user) async {
    try {
      await _db.open();
      final collection = _db.collection(UserModel.collectionName);
      await collection.insert(user.toJson());
      print('User added to MongoDB with ID: ${user.userID}');
    } catch (e) {
      print('Error adding user to MongoDB: $e');
    } finally {
      await _db.close();
    }
  }

  @override
  Future<bool> updateUser(UserModel model) async {
    try {
      await _db.open();
      final collection = _db.collection(UserModel.collectionName);
      final result = await collection.update(
        where.eq('userID', model.userID),
        model.toJson(),
      );
      return result['n'] > 0; // Check if any document was updated
    } catch (e) {
      print('Error updating user in MongoDB: $e');
      return false;
    } finally {
      await _db.close();
    }
  }

  @override
  Future<UserModel> getUserById(String id) async {
    try {
      await _db.open();
      final collection = _db.collection(UserModel.collectionName);
      final result = await collection.findOne(where.eq('userID', id));
      if (result != null) {
        return UserModel.fromJson(result);
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      print('Error fetching user by ID from MongoDB: $e');
      rethrow;
    } finally {
      await _db.close();
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      await _db.open();
      final collection = _db.collection(UserModel.collectionName);
      final results = await collection.find().toList();
      return results.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching all users from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }

  @override
  Future<List<UserModel>> getAllCustomers() async {
    try {
      await _db.open();
      final collection = _db.collection(UserModel.collectionName);
      final results = await collection.find(where.eq('userType', UserType.CUSTOMER)).toList();
      return results.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching all customers from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }

  @override
  Future<List<UserModel>> getAllBarbers() async {
    try {
      await _db.open();
      final collection = _db.collection(UserModel.collectionName);
      final results = await collection.find(where.eq('userType', UserType.BARBER)).toList();
      return results.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching all barbers from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }

  @override
  Future<List<UserModel>> getAllAdmins() async {
    try {
      await _db.open();
      final collection = _db.collection(UserModel.collectionName);
      final results = await collection.find(where.eq('userType', UserType.ADMIN)).toList();
      return results.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching all admins from MongoDB: $e');
      return [];
    } finally {
      await _db.close();
    }
  }

  @override
  Future<int> getBarbersCount() async {
    try {
      final barbers = await getAllBarbers();
      return barbers.length;
    } catch (e) {
      print('Error counting barbers in MongoDB: $e');
      return 0;
    }
  }

  @override
  Future<int> getCustomersCount() async {
    try {
      final customers = await getAllCustomers();
      return customers.length;
    } catch (e) {
      print('Error counting customers in MongoDB: $e');
      return 0;
    }
  }
}
