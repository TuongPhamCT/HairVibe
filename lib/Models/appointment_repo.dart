import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:hairvibe/Models/appointment_model.dart';
import 'package:hairvibe/Utility.dart';

class AppointmentRepository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addAppointmentToFirestore(AppointmentModel model) async {
    try {
      DocumentReference docRef = _storage.collection(AppointmentModel.collectionName).doc(model.appointmentID);
      await docRef.set(model.toJson()).whenComplete(()
        => print('Appointments added to Firestore with ID: ${docRef.id}'));
    } catch (e) {
      print('Error adding Appointments to Firestore: $e');
    }
  }

  Future<bool> updateAppointment(AppointmentModel model) async {
    bool isSuccess = false;

    await _storage.collection(AppointmentModel.collectionName)
        .doc(model.appointmentID)
        .update(model.toJson())
        .then((_) => isSuccess = true);

    return isSuccess;
  }

  Future<AppointmentModel?> getAppointmentById(String id) async {
    try {
      final DocumentReference<Map<String, dynamic>> collectionRef = _storage.collection(AppointmentModel.collectionName).doc(id);
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await collectionRef.get();

      final AppointmentModel appointment = AppointmentModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      return appointment;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<AppointmentModel>> getAllAppointments() async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(AppointmentModel.collectionName).get();
      final appointments = querySnapshot
          .docs
          .map((doc) => AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return appointments;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<AppointmentModel>> getAllCancelledAppointments(String id) async {
    try {
      final QuerySnapshot querySnapshot
      = await _storage.collection(AppointmentModel.collectionName)
          .where('status', isEqualTo: AppointmentStatus.CANCELLED)
          .where('customerID', isEqualTo: id)
          .get();
      final appointments = querySnapshot
          .docs
          .map((doc) => AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return appointments;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<AppointmentModel>> getAllCompletedAppointments(String id) async {
    try {
      final QuerySnapshot querySnapshot
      = await _storage.collection(AppointmentModel.collectionName)
          .where('status', isEqualTo: AppointmentStatus.COMPLETED)
          .where('customerID', isEqualTo: id)
          .get();
      final appointments = querySnapshot
          .docs
          .map((doc) => AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return appointments;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<AppointmentModel>> getAllUpcomingAppointments(String id) async {
    try {
      final QuerySnapshot querySnapshot
      = await _storage.collection(AppointmentModel.collectionName)
          .where('status', isEqualTo: AppointmentStatus.UPCOMING)
          .where('customerID', isEqualTo: id)
          .get();
      final appointments = querySnapshot
          .docs
          .map((doc) => AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return appointments;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<AppointmentModel>> getAppointmentsByUserId(String id) async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(AppointmentModel.collectionName)
          .where('customerID', isEqualTo: id).get();
      final appointments = querySnapshot
          .docs
          .map((doc) => AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return appointments;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<AppointmentModel>> getAppointmentsByDate(DateTime date) async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(AppointmentModel.collectionName)
          .get();
      final appointments = querySnapshot
          .docs
          .map((doc) => AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      final List<AppointmentModel> result =
        appointments.where((appointment) => Utility.isSameDate(appointment.date, date)).toList();
      return result;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<AppointmentModel>> getActiveAppointmentsByDate(DateTime date) async {
    try {
      final QuerySnapshot querySnapshot
        = await _storage.collection(AppointmentModel.collectionName)
            .where('status', whereIn: [AppointmentStatus.COMPLETED, AppointmentStatus.UPCOMING])
            .get();
      final appointments = querySnapshot
          .docs
          .map((doc) => AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      final List<AppointmentModel> result =
      appointments.where((appointment) => Utility.isSameDate(appointment.date, date)).toList();
      return result;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<AppointmentModel>> getAppointmentsByUserIdAndDate(String id, DateTime date) async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(AppointmentModel.collectionName)
          .where('customerID', isEqualTo: id)
          .get();
      final appointments = querySnapshot
          .docs
          .map((doc) => AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      final List<AppointmentModel> result =
        appointments.where((appointment) => Utility.isSameDate(appointment.date, date)).toList();
      return result;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<AppointmentModel>> getAppointmentsByBarberIdAndDate(String id, DateTime date) async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(AppointmentModel.collectionName)
          .where('barberID', isEqualTo: id)
          .get();
      final appointments = querySnapshot
          .docs
          .map((doc) => AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      final List<AppointmentModel> result =
      appointments.where((appointment) => Utility.isSameDate(appointment.date, date)).toList();
      return result;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<AppointmentModel>> getActiveAppointmentsByBarberIdAndDate(String id, DateTime date) async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(AppointmentModel.collectionName)
          .where('barberID', isEqualTo: id)
          .where('status', whereIn: [AppointmentStatus.COMPLETED, AppointmentStatus.UPCOMING])
          .get();
      final appointments = querySnapshot
          .docs
          .map((doc) => AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      final List<AppointmentModel> result =
      appointments.where((appointment) => Utility.isSameDate(appointment.date, date)).toList();
      return result;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<AppointmentModel>> getCompletedAppointmentsByBarberIdAndDate(String id, DateTime date) async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(AppointmentModel.collectionName)
          .where('barberID', isEqualTo: id)
          .where('status', isEqualTo: AppointmentStatus.COMPLETED)
          .get();
      final appointments = querySnapshot
          .docs
          .map((doc) => AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      final List<AppointmentModel> result =
      appointments.where((appointment) => Utility.isSameDate(appointment.date, date)).toList();
      return result;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<AppointmentModel>> getAppointmentsByBarberId(String id) async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(AppointmentModel.collectionName)
          .where('barberID', isEqualTo: id).get();
      final appointments = querySnapshot
          .docs
          .map((doc) => AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return appointments;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<AppointmentModel>> getAppointmentsByUserIdAndBarberId(String userID, String barberID) async {
    try {
      final QuerySnapshot querySnapshot = await _storage.collection(AppointmentModel.collectionName)
          .where('userID', isEqualTo: userID)
          .where('barberID', isEqualTo: barberID)
          .get();
      final appointments = querySnapshot
          .docs
          .map((doc) => AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return appointments;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<String> generateAppointmentID(String barberID, String userID) async {
    List<AppointmentModel> appointments = await getAllAppointments();
    int count = appointments.length;
    return count.toString().padLeft(8, '0');
  }
}
