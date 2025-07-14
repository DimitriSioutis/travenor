import 'package:equatable/equatable.dart';

abstract class PopularPlacesEvent extends Equatable {
  const PopularPlacesEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularPlaces extends PopularPlacesEvent {}
