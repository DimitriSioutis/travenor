import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance, _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> signUp({required String email, required String password, required String username}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      print('userCredential.credential: ${userCredential.credential}');
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({'username': username, 'email': email, 'uid': user.uid, 'createdAt': Timestamp.now()});
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    print('userCredential.credential: ${userCredential.credential}');
  }

  Future<void> signOut() async {}
}
