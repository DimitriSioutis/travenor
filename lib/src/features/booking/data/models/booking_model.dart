import 'package:travenor/src/features/places/domain/models/place.dart';
import '../../../places/data/models/place_model.dart';
import '../../domain/models/booking.dart';

class BookingModel {
  final DateTime bookedAt;
  final Place place;

  const BookingModel({required this.bookedAt, required this.place});

  factory BookingModel.fromMap(Map<String, dynamic> data) {
    return BookingModel(
      bookedAt: (data['bookedAt']).toDate(),
      place: PlaceModel.fromMap(data['place']).toDomain(),
    );
  }

  Booking toDomain() {
    return Booking(
      bookedAt: bookedAt,
      place: place,
    );
  }
}
