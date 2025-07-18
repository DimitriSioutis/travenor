import 'package:bloc/bloc.dart';
import '../../../../places/domain/models/place.dart';
import '../../../domain/repositories/favorites_repository.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository _favoritesRepository;

  FavoritesBloc({required FavoritesRepository favoritesRepository}) : _favoritesRepository = favoritesRepository, super(FavoritesInitial()) {
    on<LoadFavorites>(
      (event, emit) {
        return emit.onEach<Set<Place>>(
          _favoritesRepository.getFavoritePlaces(event.userId),
          onData: (favoritePlaces) => emit(FavoritesLoaded(favoritePlaces)),
        );
      },
    );

    on<AddFavorite>(
      (event, emit) {
        _favoritesRepository.addFavorite(event.userId, event.place);
      },
    );
    on<RemoveFavorite>(
      (event, emit) {
        _favoritesRepository.removeFavorite(event.userId, event.placeId);
      },
    );
  }
}
