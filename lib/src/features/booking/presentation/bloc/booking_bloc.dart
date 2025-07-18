import 'package:bloc/bloc.dart';
import 'package:travenor/src/features/booking/presentation/bloc/booking_event.dart';
import 'package:travenor/src/features/booking/presentation/bloc/booking_state.dart';

import '../../domain/models/booking.dart';
import '../../domain/repositories/booking_repository.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository _bookingRepository;

  BookingBloc({required BookingRepository bookingRepository}) : _bookingRepository = bookingRepository, super(BookingInitial()) {
    on<LoadBookedPlaces>(
      (event, emit) {
        return emit.onEach<Set<Booking>>(
          _bookingRepository.getBookedPlaces(userId: event.userId),
          onData: (bookedPlaces) => emit(BookingLoaded(bookedPlaces)),
        );
      },
    );

    on<BookPlace>(
      (event, emit) {
        _bookingRepository.bookPlace(userId: event.userId, bookedAt: event.bookedAt, place: event.place);
      },
    );

    on<CancelBookedPlace>(
      (event, emit) {
        _bookingRepository.cancelBooking(userId: event.userId, placeId: event.placeId);
      },
    );
  }
}
