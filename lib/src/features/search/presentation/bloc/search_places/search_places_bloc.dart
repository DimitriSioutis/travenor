import 'package:bloc/bloc.dart';
import '../../../../places/data/repositories/places_repository.dart';
import '../../../../places/domain/models/place.dart';
import 'search_places_event.dart';
import 'search_places_state.dart';

class SearchPlacesBloc extends Bloc<SearchPlacesEvent, SearchPlacesState> {
  final PlacesRepository _placesRepository;

  SearchPlacesBloc({required PlacesRepository placesRepository}) : _placesRepository = placesRepository, super(SearchPlacesInitial()) {
    on<SearchPlacesRequested>((event, emit) async {
      emit(SearchPlacesLoading());
      try {
        List<Place> places = await _placesRepository.searchPlaces(query: event.query);
        emit(SearchPlacesLoaded(places));
      } catch (e) {
        emit(SearchPlacesError(e.toString()));
      }
    });
  }
}
