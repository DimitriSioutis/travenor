import 'package:bloc/bloc.dart';
import 'calendar_event.dart';
import 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarState(selectedDate: DateTime.now())) {
    on<DateSelected>(
      (event, emit) {
        emit(state.copyWith(selectedDate: event.selectedDate));
      },
    );
  }
}
