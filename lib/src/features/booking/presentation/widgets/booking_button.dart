import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travenor/src/features/booking/presentation/bloc/booking_event.dart';
import '../../../../common_widgets/general_button.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth/auth_state.dart';
import '../../../places/domain/models/place.dart';
import '../../domain/models/booking.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_state.dart';
import 'booking_book_dialog.dart';
import 'booking_cancel_dialog.dart';

class BookingButton extends StatelessWidget {
  final Place place;
  const BookingButton({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (BuildContext context, BookingState state) {
        final authState = context.read<AuthBloc>().state;
        final userId = (authState is Authenticated) ? authState.user.uid : null;

        bool isBooked = false;
        String buttonText = 'Book Now';
        Booking? booking;
        if (state is BookingLoaded) {
          booking = state.bookedPlaces.firstWhereOrNull((booking) => booking.place == place);
          isBooked = booking != null;
          buttonText = booking != null ? 'Booked at ${DateFormat('dd MMMM yyyy').format(booking.bookedAt)}' : 'Book Now';
        }
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: MediaQuery.of(context).padding.bottom + 10),
            child: GeneralButton(
              textStyle: isBooked
                  ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              buttonColor: isBooked ? Theme.of(context).colorScheme.surface : null,
              borderColor: isBooked ? Theme.of(context).colorScheme.primary : null,
              onTap: () {
                if (userId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please log in to book place')),
                  );
                  return;
                }
                if (isBooked) {
                  _showCancelBookingDialog(context, userId: userId);
                } else {
                  _showBookingDialog(context, userId: userId);
                }
              },
              buttonText: buttonText,
            ),
          ),
        );
      },
    );
  }

  _showBookingDialog(BuildContext context, {required String userId}) async {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BookingDialog(
          submit: (selectedDate) {
            context.read<BookingBloc>().add(BookPlace(place: place, userId: userId, bookedAt: selectedDate));
          },
        );
      },
    );
  }

  _showCancelBookingDialog(BuildContext context, {required String userId}) async {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CancelBookingDialog(
          submit: () {
            context.read<BookingBloc>().add(CancelBookedPlace(placeId: place.id, userId: userId));
          },
        );
      },
    );
  }
}
