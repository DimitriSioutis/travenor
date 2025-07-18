import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travenor/src/features/places/domain/models/place.dart';
import '../../domain/repositories/places_repository.dart';
import '../models/place_model.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  final FirebaseFirestore _firestore;

  PlacesRepositoryImpl({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Place>> getPopularPlaces() async {
    try {
      final querySnapshot = await _firestore.collection('places').where('isPopular', isEqualTo: true).get();
      return querySnapshot.docs.map((rawPlace) => PlaceModel.fromSnapshot(rawPlace).toDomain()).toList();
    } catch (e) {
      throw Exception("Failed to get popular places: ${e.toString()}");
    }
  }

  @override
  Future<List<Place>> searchPlaces({required String query}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot;
      if (query.isEmpty) {
        querySnapshot = await _firestore.collection('places').limit(10).get();
      } else {
        querySnapshot = await _firestore.collection('places').where('name', isGreaterThanOrEqualTo: query).where('name', isLessThanOrEqualTo: '$query\uf8ff').limit(20).get();
      }
      List<Place> places = querySnapshot.docs.map((rawPlace) => PlaceModel.fromSnapshot(rawPlace).toDomain()).toList();
      return places;
    } catch (e) {
      throw Exception("Failed to search_places places: ${e.toString()}");
    }
  }

  @override
  Future<Place> getPlaceDetails({required String placeId}) async {
    try {
      final rawPlace = await _firestore.collection('places').doc(placeId).get();
      if (rawPlace.exists) {
        return PlaceModel.fromSnapshot(rawPlace).toDomain();
      } else {
        throw Exception('Place not found.');
      }
    } catch (e) {
      throw Exception('Failed to fetch places details.');
    }
  }
}
