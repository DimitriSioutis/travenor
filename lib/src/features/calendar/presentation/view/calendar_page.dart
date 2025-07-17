import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travenor/src/features/booking/presentation/widgets/booked_places_list.dart';
import '../../../booking/domain/models/booking.dart';
import '../../../booking/presentation/bloc/booking_bloc.dart';
import '../../../booking/presentation/bloc/booking_state.dart';
import '../bloc/calendar_bloc.dart';
import '../bloc/calendar_event.dart';
import '../bloc/calendar_state.dart';
import '../widgets/custom_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          final selectedDate = state.selectedDate;
          return Column(
            children: [
              CustomCalendar(
                selectedDate: selectedDate,
                onDaySelected: (selectedDay, focusedDay) {
                  context.read<CalendarBloc>().add(DateSelected(selectedDay));
                },
              ),
              const SizedBox(height: 40),
              _buildListHeader(context),
              Expanded(
                child: BlocBuilder<BookingBloc, BookingState>(
                  builder: (context, state) {
                    if (state is BookingLoading) Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
                    if (state is BookingLoaded) {
                      final List<Booking> filteredBookings = state.bookedPlaces.where(
                        (booking) {
                          return DateFormat('dd MMMM yyyy').format(booking.bookedAt) == DateFormat('dd MMMM yyyy').format(selectedDate);
                        },
                      ).toList();
                      if (filteredBookings.isEmpty) {
                        return Center(child: Text('No bookings found', style: Theme.of(context).textTheme.titleLarge));
                      }
                      return BookedPlacesList(bookings: filteredBookings);
                    }
                    return Center(child: Text('Something went wrong', style: Theme.of(context).textTheme.titleLarge));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'My Schedule',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/booked_places'),
          child: Text(
            'View All',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
