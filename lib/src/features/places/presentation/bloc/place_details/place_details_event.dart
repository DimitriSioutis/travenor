import 'package:equatable/equatable.dart';

abstract class PlaceDetailsEvent extends Equatable {
  const PlaceDetailsEvent();

  @override
  List<Object?> get props => [];
}

class FetchPlaceDetails extends PlaceDetailsEvent {
  final String placeId;

  const FetchPlaceDetails(this.placeId);

  @override
  List<Object?> get props => [];
}
