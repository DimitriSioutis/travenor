import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travenor/data/models/place.dart';

class PlacesRepository {
  final FirebaseFirestore _firestore;

  PlacesRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Place>> getPopularPlaces() async {
    try {
      final querySnapshot = await _firestore.collection('places').where('isPopular', isEqualTo: true).get();
      return querySnapshot.docs.map((rowPlace) => Place.fromSnapshot(rowPlace)).toList();
    } catch (e) {
      throw Exception("Failed to get popular places: ${e.toString()}");
    }
  }

  Future<List<Place>> searchPlaces({required String query}) async {
    try {
      // Search places here is bad conditon when i have too much places. But for now working
      // final querySnapshot = await _firestore.collection('places').where('name', isGreaterThanOrEqualTo: query).where('name', isLessThanOrEqualTo: '$query\uf8ff').limit(1).get();
      final querySnapshot = await _firestore.collection('places').get();
      List<Place> places = querySnapshot.docs.map((rowPlace) => Place.fromSnapshot(rowPlace)).toList();
      List<Place> filteredPlaces = places.where((place) => place.name.toLowerCase().contains(query.toLowerCase())).toList();
      return query == '' ? places : filteredPlaces;
    } catch (e) {
      throw Exception("Failed to search_places places: ${e.toString()}");
    }
  }

  Future<Place> getPlaceDetails({required String placeId}) async {
    try {
      final rawPlace = await _firestore.collection('places').doc(placeId).get();
      if (rawPlace.exists) {
        return Place.fromSnapshot(rawPlace);
      } else {
        throw Exception('Place not found.');
      }
    } catch (e) {
      throw Exception('Failed to fetch place details.');
    }
  }
}
