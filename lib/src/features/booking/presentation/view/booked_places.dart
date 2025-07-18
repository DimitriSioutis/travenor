import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common_widgets/travenor_back_button.dart';
import '../../domain/models/booking.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_state.dart';
import '../widgets/booked_places_list.dart';

class BookedPlacesScreen extends StatelessWidget {
  const BookedPlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20 + MediaQuery.of(context).padding.top, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TravenorBackButton(),
                    Text(
                      'Booked Places',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(width: 44),
                  ],
                ),
                const SizedBox(height: 40),
                Text(
                  'All Booked Places',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          Expanded(
            child: BlocBuilder<BookingBloc, BookingState>(
              builder: (context, state) {
                return _buildBookingList(state, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingList(BookingState state, BuildContext context) {
    if (state is BookingLoading) Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
    if (state is BookingLoaded) {
      final List<Booking> filteredBookings = state.bookedPlaces.toList();
      if (filteredBookings.isEmpty) {
        return Center(child: Text('No bookings found', style: Theme.of(context).textTheme.titleLarge));
      }
      return BookedPlacesList(bookings: filteredBookings);
    }
    return Center(child: Text('Something went wrong', style: Theme.of(context).textTheme.titleLarge));
  }
}
