import 'package:firebase_auth/firebase_auth.dart';

class AuthenticatorFacade {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current user ID
  String? get userId => FirebaseAuth.instance.currentUser?.uid;
  String? get userEmail => FirebaseAuth.instance.currentUser?.email;

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Sign out failed: $e");
    }
  }

  // Sign in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }

  // sign up
  Future<UserCredential?> signUpWithEmailAndPassword(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress.trim(),
        password: password.trim(),
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // check email
  Future<bool?> checkIfEmailExists(String emailAddress) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: '123456',
      );
      await credential.user?.delete();
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return true;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // send reset password email
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('@AuthFacade: No user found with this email.');
      } else if (e.code == 'invalid-email') {
        print('@AuthFacade: Invalid email format.');
      }
      return false;
    }
  }

  // Change password
  Future<bool> changePassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updatePassword(newPassword);
        print("@AuthFacade: Password changed successfully.");
        return true;
      } else {
        print("@AuthFacade: No user is signed in.");
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('@AuthFacade: The password is too weak.');
      } else if (e.code == 'requires-recent-login') {
        print('@AuthFacade: Please re-authenticate to change your password.');
      } else {
        print('@AuthFacade: Error: ${e.message}');
      }
      return false;
    }
  }
}