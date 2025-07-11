import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../data/repositories/favorites_repository_impl.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepositoryImpl _favoritesRepository;

  FavoritesBloc({required FavoritesRepositoryImpl favoritesRepository}) : _favoritesRepository = favoritesRepository, super(FavoritesInitial()) {
    on<LoadFavorites>(
      (event, emit) {
        return emit.onEach<Set<String>>(
          _favoritesRepository.getFavoritePlaces(event.userId),
          onData: (favoriteIds) => emit(FavoritesLoaded(favoriteIds)),
        );
      },
    );

    on<AddFavorite>(
      (event, emit) {
        _favoritesRepository.addFavorite(event.userId, event.placeId);
      },
    );
    on<RemoveFavorite>(
      (event, emit) {
        _favoritesRepository.removeFavorite(event.userId, event.placeId);
      },
    );
  }
}
