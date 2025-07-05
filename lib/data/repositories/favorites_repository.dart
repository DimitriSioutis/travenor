import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesRepository {
  final FirebaseFirestore _firestore;

  FavoritesRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<Set<String>> getFavoritePlaces(String userId) {
    return _firestore.collection('users').doc(userId).collection('favorites').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.id).toSet();
    });
  }

  Future<void> addFavorite(String userId, String placeId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(placeId) // Use the placeId as the document ID
        .set({
          'favoritedAt': Timestamp.now(),
        });
  }

  Future<void> removeFavorite(String userId, String placeId) async {
    await _firestore.collection('users').doc(userId).collection('favorites').doc(placeId).delete();
  }
}
