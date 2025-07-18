import '../../../places/domain/models/place.dart';

abstract class FavoritesRepository {
  // Stream<Set<String>> getFavoritePlacesIds(String userId);
  Stream<Set<Place>> getFavoritePlaces(String userId);
  Future<void> addFavorite(String userId, Place place);
  Future<void> removeFavorite(String userId, String placeId);
}
