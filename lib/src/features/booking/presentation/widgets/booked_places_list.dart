import 'package:flutter/material.dart';
import '../../domain/models/booking.dart';
import 'booked_place_card.dart';

class BookedPlacesList extends StatelessWidget {
  const BookedPlacesList({super.key, required this.bookings});
  final List<Booking> bookings;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: bookings.length,
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        final booking = bookings.elementAt(index);
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: BookedPlaceCard(
            booking: booking,
            onTap: () {
              Navigator.pushNamed(context, '/place_details', arguments: booking.place.id);
            },
          ),
        );
      },
    );
  }
}
