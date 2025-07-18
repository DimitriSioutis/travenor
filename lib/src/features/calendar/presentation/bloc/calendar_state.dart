import 'package:equatable/equatable.dart';

class CalendarState extends Equatable {
  final DateTime selectedDate;

  const CalendarState({required this.selectedDate});

  CalendarState copyWith({DateTime? selectedDate}) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object> get props => [selectedDate];
}
