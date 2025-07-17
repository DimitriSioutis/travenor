import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {
  final String userId;
  const LoadFavorites(this.userId);
}

class AddFavorite extends FavoritesEvent {
  final String userId;
  final String placeId;
  const AddFavorite({required this.userId, required this.placeId});
}

class RemoveFavorite extends FavoritesEvent {
  final String userId;
  final String placeId;
  const RemoveFavorite({required this.userId, required this.placeId});
}
