import 'package:equatable/equatable.dart';

import '../../domain/models/booking.dart';

abstract class BookingState extends Equatable {
  const BookingState();
  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final Set<Booking> bookedPlaces;
  const BookingLoaded(this.bookedPlaces);
  @override
  List<Object?> get props => [bookedPlaces];
}
