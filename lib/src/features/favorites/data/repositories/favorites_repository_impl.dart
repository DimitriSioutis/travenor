import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../places/data/models/place_model.dart';
import '../../../places/domain/models/place.dart';
import '../../domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FirebaseFirestore _firestore;

  FavoritesRepositoryImpl({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<Set<Place>> getFavoritePlaces(String userId) {
    return _firestore.collection('users').doc(userId).collection('favorites').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Place place = PlaceModel.fromMap(doc.data()['place']).toDomain();
        return place;
      }).toSet();
    });
  }

  @override
  Future<void> addFavorite(String userId, Place place) async {
    await _firestore.collection('users').doc(userId).collection('favorites').doc(place.id).set({
      'favoritedAt': Timestamp.now(),
      'place': place.toJson(),
    });
  }

  @override
  Future<void> removeFavorite(String userId, String placeId) async {
    await _firestore.collection('users').doc(userId).collection('favorites').doc(placeId).delete();
  }
}
