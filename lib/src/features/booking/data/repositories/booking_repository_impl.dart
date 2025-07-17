import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travenor/src/features/booking/domain/repositories/booking_repository.dart';
import '../../../places/domain/models/place.dart';
import '../../domain/models/booking.dart';
import '../models/booking_model.dart';

class BookingRepositoryImpl implements BookingRepository {
  final FirebaseFirestore _firestore;

  BookingRepositoryImpl({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<Set<Booking>> getBookedPlaces({required String userId}) {
    return _firestore.collection('users').doc(userId).collection('bookedPlaces').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Booking booking = BookingModel.fromMap(doc.data()).toDomain();
        return booking;
      }).toSet();
    });
  }

  @override
  Future<void> bookPlace({
    required String userId,
    required DateTime bookedAt,
    required Place place,
  }) async {
    await _firestore.collection('users').doc(userId).collection('bookedPlaces').doc(place.id).set({
      'bookedAt': bookedAt,
      'place': place.toJson(),
    });
  }

  @override
  Future<void> cancelBooking({required String userId, required String placeId}) async {
    await _firestore.collection('users').doc(userId).collection('bookedPlaces').doc(placeId).delete();
  }
}
