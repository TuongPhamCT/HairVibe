import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServiceRepository {
  final FirebaseFirestore _storage = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


}
