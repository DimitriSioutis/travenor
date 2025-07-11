import 'package:bloc/bloc.dart';
import '../../../domain/models/place.dart';
import '../../../domain/repositories/places_repository.dart';
import 'popular_places_event.dart';
import 'popular_places_state.dart';

class PopularPlacesBloc extends Bloc<PopularPlacesEvent, PopularPlacesState> {
  final PlacesRepository _placesRepository;

  PopularPlacesBloc({required PlacesRepository placesRepository}) : _placesRepository = placesRepository, super(PopularPlacesInitial()) {
    on<FetchPopularPlaces>((event, emit) async {
      emit(PopularPlacesLoading());

      try {
        List<Place> popularPlaces = await _placesRepository.getPopularPlaces();
        emit(PopularPlacesLoaded(popularPlaces));
      } catch (e) {
        emit(PopularPlacesError(e.toString()));
      }
    });
  }
}
