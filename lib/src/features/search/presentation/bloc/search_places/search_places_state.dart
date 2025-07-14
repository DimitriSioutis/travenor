import 'package:equatable/equatable.dart';

import '../../../../places/domain/models/place.dart';

abstract class SearchPlacesState extends Equatable {
  const SearchPlacesState();
  @override
  List<Object> get props => [];
}

class SearchPlacesInitial extends SearchPlacesState {}

class SearchPlacesLoading extends SearchPlacesState {}

class SearchPlacesLoaded extends SearchPlacesState {
  final List<Place> places;
  const SearchPlacesLoaded(this.places);
  @override
  List<Object> get props => [places];
}

class SearchPlacesError extends SearchPlacesState {
  final String message;

  const SearchPlacesError(this.message);

  @override
  List<Object> get props => [message];
}
