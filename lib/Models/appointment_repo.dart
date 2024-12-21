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

  Future<AppointmentModel> getAppointmentById(String id) async {
    final DocumentReference<Map<String, dynamic>> collectionRef = _storage.collection(AppointmentModel.collectionName).doc(id);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await collectionRef.get();

    final AppointmentModel appointment = AppointmentModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    return appointment;
  }

  Future<List<AppointmentModel>> getAllAppointments(String id) async {
    final QuerySnapshot querySnapshot = await _storage.collection(AppointmentModel.collectionName).get();
    final appointments = querySnapshot
        .docs
        .map((doc) => AppointmentModel.fromJson(doc as Map<String, dynamic>))
        .toList();
    return appointments;
  }

  Future<List<AppointmentModel>> getAllCancelledAppointments(String id) async {
    final QuerySnapshot querySnapshot
        = await _storage.collection(AppointmentModel.collectionName)
                        .where('status', isEqualTo: AppointmentStatus.CANCELLED)
                        .where('barberID', isEqualTo: id)
                        .get();
    final appointments = querySnapshot
        .docs
        .map((doc) => AppointmentModel.fromJson(doc as Map<String, dynamic>))
        .toList();
    return appointments;
  }

  Future<List<AppointmentModel>> getAllCompletedAppointments(String id) async {
    final QuerySnapshot querySnapshot
        = await _storage.collection(AppointmentModel.collectionName)
                        .where('status', isEqualTo: AppointmentStatus.COMPLETED)
                        .where('barberID', isEqualTo: id)
                        .get();
    final appointments = querySnapshot
        .docs
        .map((doc) => AppointmentModel.fromJson(doc as Map<String, dynamic>))
        .toList();
    return appointments;
  }

  Future<List<AppointmentModel>> getAllUpcomingAppointments(String id) async {
    final QuerySnapshot querySnapshot
        = await _storage.collection(AppointmentModel.collectionName)
                        .where('status', isEqualTo: AppointmentStatus.UPCOMING)
                        .where('barberID', isEqualTo: id)
                        .get();
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

  Future<List<AppointmentModel>> getAppointmentsByUserIdAndDate(String id, DateTime date) async {
    final QuerySnapshot querySnapshot = await _storage.collection(AppointmentModel.collectionName)
        .where('customerID', isEqualTo: id)
        .where('date', isEqualTo: date)
        .get();
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

  Future<List<AppointmentModel>> getAppointmentsByUserIdAndBarberId(String userID, String barberID) async {
    final QuerySnapshot querySnapshot = await _storage.collection(AppointmentModel.collectionName)
        .where('userID', isEqualTo: userID)
        .where('barberID', isEqualTo: barberID)
        .get();
    final appointments = querySnapshot
        .docs
        .map((doc) => AppointmentModel.fromJson(doc as Map<String, dynamic>))
        .toList();
    return appointments;
  }

  Future<String> generateAppointmentID(String barberID, String userID) async {
    List<AppointmentModel> appointments = await getAppointmentsByUserIdAndBarberId(userID, barberID);
    int count = appointments.length;
    return "$barberID$userID${count.toString().padLeft(4, '0')}";
  }
}
