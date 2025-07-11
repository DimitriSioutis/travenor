import 'package:bloc/bloc.dart';
import 'package:travenor/src/features/places/data/repositories/places_repository_impl.dart';
import '../../../domain/models/place.dart';
import 'popular_places_event.dart';
import 'popular_places_state.dart';

class PopularPlacesBloc extends Bloc<PopularPlacesEvent, PopularPlacesState> {
  final PlacesRepositoryImpl _placesRepository;

  PopularPlacesBloc({required PlacesRepositoryImpl placesRepository}) : _placesRepository = placesRepository, super(PopularPlacesInitial()) {
    on<FetchPopularPlaces>((event, emit) async {
      emit(PopularPlacesLoading());

      try {
        List<Place> popularPlaces = await placesRepository.getPopularPlaces();
        emit(PopularPlacesLoaded(popularPlaces));
      } catch (e) {
        emit(PopularPlacesError(e.toString()));
      }
    });
  }
}
