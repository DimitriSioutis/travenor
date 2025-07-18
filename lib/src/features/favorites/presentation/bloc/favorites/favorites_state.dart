import 'package:equatable/equatable.dart';

import '../../../../places/domain/models/place.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();
  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final Set<Place> favoritePlaces;
  const FavoritesLoaded(this.favoritePlaces);
  @override
  List<Object?> get props => [favoritePlaces];
}
