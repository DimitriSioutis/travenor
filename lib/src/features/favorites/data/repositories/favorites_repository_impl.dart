import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FirebaseFirestore _firestore;

  FavoritesRepositoryImpl({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<Set<String>> getFavoritePlaces(String userId) {
    return _firestore.collection('users').doc(userId).collection('favorites').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.id).toSet();
    });
  }

  @override
  Future<void> addFavorite(String userId, String placeId) async {
    await _firestore.collection('users').doc(userId).collection('favorites').doc(placeId).set({
      'favoritedAt': Timestamp.now(),
    });
  }

  @override
  Future<void> removeFavorite(String userId, String placeId) async {
    await _firestore.collection('users').doc(userId).collection('favorites').doc(placeId).delete();
  }
}
