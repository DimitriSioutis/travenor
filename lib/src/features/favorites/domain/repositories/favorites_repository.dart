abstract class FavoritesRepository {
  Stream<Set<String>> getFavoritePlaces(String userId);
  Future<void> addFavorite(String userId, String placeId);
  Future<void> removeFavorite(String userId, String placeId);
}
