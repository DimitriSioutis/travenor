import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travenor/data/models/tavenor_user.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance, _firestore = firestore ?? FirebaseFirestore.instance;

  Future<User> signUp({required String email, required String password, required String username}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
          'uid': user.uid,
          'createdAt': Timestamp.now(),
        });
        return user;
      } else {
        throw Exception("Sign up failed: Could not create user.");
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<User> signIn({required String email, required String password}) async {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

    if (userCredential.user == null) {
      throw Exception("Sign in failed: User not found.");
    }
    return userCredential.user!;
  }

  Future<TravenorUser> getTravenorUser(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return TravenorUser.fromMap(doc.data()!);
      } else {
        throw Exception("User profile not found.");
      }
    } catch (e) {
      throw Exception("Failed to get user details: ${e.toString()}");
    }
  }

  Future<void> signOut() async {}
}
