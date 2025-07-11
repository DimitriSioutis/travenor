import 'package:bloc/bloc.dart';
import 'package:travenor/src/features/places/data/repositories/places_repository_impl.dart';

import '../../../domain/models/place.dart';
import '../../../domain/repositories/places_repository.dart';
import 'place_details_event.dart';
import 'place_details_state.dart';

class PlaceDetailsBloc extends Bloc<PlaceDetailsEvent, PlaceDetailsState> {
  final PlacesRepository _placesRepository;

  PlaceDetailsBloc({required PlacesRepository placesRepository}) : _placesRepository = placesRepository, super(PlaceDetailsInitial()) {
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
