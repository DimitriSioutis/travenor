import 'package:bloc/bloc.dart';
import 'package:travenor/data/repositories/places_repository.dart';
import '../../../data/models/place.dart';
import 'popular_places_event.dart';
import 'popular_places_state.dart';

class PopularPlacesBloc extends Bloc<PopularPlacesEvent, PopularPlacesState> {
  final PlacesRepository _placesRepository;

  PopularPlacesBloc({required PlacesRepository placesRepository}) : _placesRepository = placesRepository, super(PopularPlacesInitial()) {
    on<FetchPopularPlaces>((event, emit) async {
      emit(PopularPlacesLoading());

      try {
        print('start fetching popular places');

        List<Place> popularPlaces = await placesRepository.getPopularPlaces();
        print('popular places fetched ${popularPlaces.length}');

        emit(PopularPlacesLoaded(popularPlaces));
      } catch (e) {
        emit(PopularPlacesError(e.toString()));
      }
    });
  }
}
