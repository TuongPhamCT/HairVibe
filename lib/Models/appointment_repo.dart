import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:hairvibe/Models/appointment_model.dart';

class AppointmentRepository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  void addAppointmentToFirestore(AppointmentModel model) async {
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

  Future<List<AppointmentModel>> getAllAppointments(String id) async {
    final QuerySnapshot querySnapshot = await _storage.collection(AppointmentModel.collectionName).get();
    final appointments = querySnapshot
        .docs
        .map((doc) => AppointmentModel.fromJson(doc as Map<String, dynamic>))
        .toList();
    return appointments;
  }

  Future<List<AppointmentModel>> getAppointmentsByUserId(String id) async {
    final QuerySnapshot querySnapshot = await _storage.collection(AppointmentModel.collectionName)
                                                      .where('customerID', isEqualTo: id).get();
    final appointments = querySnapshot
                          .docs
                          .map((doc) => AppointmentModel.fromJson(doc as Map<String, dynamic>))
                          .toList();
    return appointments;
  }

  Future<List<AppointmentModel>> getAppointmentsByBarberId(String id) async {
    final QuerySnapshot querySnapshot = await _storage.collection(AppointmentModel.collectionName)
        .where('barberID', isEqualTo: id).get();
    final appointments = querySnapshot
        .docs
        .map((doc) => AppointmentModel.fromJson(doc as Map<String, dynamic>))
        .toList();
    return appointments;
  }
}
