import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../data/repositories/favorites_repository.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository _favoritesRepository;
  StreamSubscription? _favoritesSubscription;

  FavoritesBloc({required FavoritesRepository favoritesRepository}) : _favoritesRepository = favoritesRepository, super(FavoritesInitial()) {
    on<LoadFavorites>(
      (event, emit) {
        _favoritesSubscription?.cancel();
        _favoritesSubscription = _favoritesRepository.getFavoritePlaces(event.userId).listen((Set<String> ids) {
          add(FavoritesUpdated(ids));
        });
      },
    );
    on<FavoritesUpdated>((event, emit) {
      emit(FavoritesLoaded(event.favoritePlaces));
    });
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
  @override
  Future<void> close() {
    _favoritesSubscription?.cancel();
    return super.close();
  }
}
