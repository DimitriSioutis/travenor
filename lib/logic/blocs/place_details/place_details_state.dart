import 'package:equatable/equatable.dart';

import '../../../data/models/place.dart';

abstract class PlaceDetailsState extends Equatable {
  const PlaceDetailsState();

  @override
  List<Object?> get props => [];
}

class PlaceDetailsInitial extends PlaceDetailsState {}

class PlaceDetailsLoading extends PlaceDetailsState {}

class PlaceDetailsLoaded extends PlaceDetailsState {
  final Place place;
  const PlaceDetailsLoaded(this.place);

  @override
  List<Object?> get props => [place];
}

class PlaceDetailsError extends PlaceDetailsState {
  final String error;
  const PlaceDetailsError(this.error);
  @override
  List<Object?> get props => [error];
}
