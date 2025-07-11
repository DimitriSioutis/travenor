import 'package:bloc/bloc.dart';
import 'package:travenor/src/features/places/data/repositories/places_repository_impl.dart';

import '../../../domain/models/place.dart';
import 'place_details_event.dart';
import 'place_details_state.dart';

class PlaceDetailsBloc extends Bloc<PlaceDetailsEvent, PlaceDetailsState> {
  final PlacesRepositoryImpl _placesRepository;

  PlaceDetailsBloc({required PlacesRepositoryImpl placesRepository}) : _placesRepository = placesRepository, super(PlaceDetailsInitial()) {
    on<FetchPlaceDetails>((event, emit) async {
      emit(PlaceDetailsLoading());
      try {
        Place place = await _placesRepository.getPlaceDetails(placeId: event.placeId);
        emit(PlaceDetailsLoaded(place));
      } catch (e) {
        emit(PlaceDetailsError(e.toString()));
      }
    });
  }
}
