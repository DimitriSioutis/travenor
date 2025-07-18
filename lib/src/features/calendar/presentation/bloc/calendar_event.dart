import 'package:equatable/equatable.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class DateSelected extends CalendarEvent {
  final DateTime selectedDate;

  const DateSelected(this.selectedDate);

  @override
  List<Object> get props => [selectedDate];
}
