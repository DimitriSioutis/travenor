import '../models/place.dart';

abstract class PlacesRepository {
  Future<List<Place>> getPopularPlaces();
  Future<List<Place>> searchPlaces({required String query});
  Future<Place> getPlaceDetails({required String placeId});
}
