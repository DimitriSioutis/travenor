import 'package:equatable/equatable.dart';

abstract class SearchPlacesEvent extends Equatable {
  const SearchPlacesEvent();
  @override
  List<Object> get props => [];
}

class SearchPlacesRequested extends SearchPlacesEvent {
  final String query;
  const SearchPlacesRequested(this.query);
  @override
  List<Object> get props => [query];
}
