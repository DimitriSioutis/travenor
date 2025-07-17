import 'package:equatable/equatable.dart';
import '../../../places/domain/models/place.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class LoadBookedPlaces extends BookingEvent {
  final String userId;
  const LoadBookedPlaces(this.userId);
}

class BookPlace extends BookingEvent {
  final String userId;
  final DateTime bookedAt;
  final Place place;
  const BookPlace({required this.userId, required this.bookedAt, required this.place});
}

class CancelBookedPlace extends BookingEvent {
  final String userId;
  final String placeId;
  const CancelBookedPlace({required this.userId, required this.placeId});
}
