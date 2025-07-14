import 'package:equatable/equatable.dart';

import '../../../domain/models/place.dart';

abstract class PopularPlacesState extends Equatable {
  const PopularPlacesState();

  @override
  List<Object> get props => [];
}

class PopularPlacesInitial extends PopularPlacesState {}

class PopularPlacesLoading extends PopularPlacesState {}

class PopularPlacesLoaded extends PopularPlacesState {
  final List<Place> places;

  const PopularPlacesLoaded(this.places);

  @override
  List<Object> get props => [places];
}

class PopularPlacesError extends PopularPlacesState {
  final String error;

  const PopularPlacesError(this.error);

  @override
  List<Object> get props => [error];
}
