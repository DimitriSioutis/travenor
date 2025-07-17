import '../../../places/domain/models/place.dart';
import '../models/booking.dart';

abstract class BookingRepository {
  Stream<Set<Booking>> getBookedPlaces({
    required String userId,
  });
  Future<void> bookPlace({
    required String userId,
    required DateTime bookedAt,
    required Place place,
  });
  Future<void> cancelBooking({
    required String userId,
    required String placeId,
  });
}
