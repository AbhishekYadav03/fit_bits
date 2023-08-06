import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signUp({required String email, required String password}) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw "This password is to weak.";
      } else if (e.code == 'email-already-in-use') {
        throw "Email already exist!";
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<UserCredential> signIn({required String email, required String password}) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  bool isAuthenticated() {
    return _firebaseAuth.currentUser != null;
  }
}
