import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travenor/src/extensions/color_scheme_extension.dart';

class CustomCalendar extends StatelessWidget {
  const CustomCalendar({super.key, required this.selectedDate, required this.onDaySelected});
  final DateTime selectedDate;
  final Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 148,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6),
            blurRadius: 20,
            spreadRadius: 0,
            color: Theme.of(context).colorScheme.shadow,
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        rowHeight: 76,
        focusedDay: selectedDate,
        selectedDayPredicate: (day) => isSameDay(selectedDate, day),
        onDaySelected: onDaySelected,
        headerVisible: true,
        headerStyle: HeaderStyle(
          headerMargin: EdgeInsets.zero,
          headerPadding: EdgeInsets.only(bottom: 11.0),
          formatButtonPadding: EdgeInsets.zero,
          leftChevronPadding: EdgeInsets.symmetric(horizontal: 16.0),
          leftChevronMargin: EdgeInsets.zero,
          rightChevronPadding: EdgeInsets.symmetric(horizontal: 16.0),
          rightChevronMargin: EdgeInsets.zero,
          titleTextFormatter: _getTittleText,
          titleTextStyle: Theme.of(context).textTheme.displayLarge!,
          titleCentered: false,
          formatButtonShowsNext: true,
        ),
        calendarFormat: CalendarFormat.week,
        availableCalendarFormats: const {
          CalendarFormat.week: 'Week',
        },

        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          defaultTextStyle: Theme.of(context).textTheme.bodyLarge!,
          weekendTextStyle: Theme.of(context).textTheme.bodyLarge!,
        ),
        daysOfWeekVisible: false,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            return _buildDatePreview(
              day,
              context,
              dayLetterTextStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
              ),
              dayNumberTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
            );
          },
          selectedBuilder: (context, day, focusedDay) {
            return _buildDatePreview(
              day,
              context,
              dayLetterTextStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
              dayNumberTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
              boxColor: Theme.of(context).colorScheme.secondary,
            );
          },
          todayBuilder: (context, day, focusedDay) {
            return _buildDatePreview(
              day,
              context,
              dayLetterTextStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
              ),
              dayNumberTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.secondary),
            );
          },
          outsideBuilder: (context, day, focusedDay) {
            return _buildDatePreview(
              day,
              context,
              dayLetterTextStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
              ),
              dayNumberTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
              ),
            );
          },
        ),
      ),
    );
  }

  String _getTittleText(date, locale) {
    String titleText = DateFormat('d MMMM').format(selectedDate);

    if (DateFormat('yyyy').format(selectedDate) == DateFormat('yyyy').format(date)) {
      if (DateFormat('MMMM').format(selectedDate) != DateFormat('MMMM').format(date)) {
        titleText = DateFormat('MMMM').format(date);
      }
    } else {
      titleText = DateFormat('MMMM yyyy').format(date);
    }
    return titleText;
  }

  Container _buildDatePreview(DateTime day, BuildContext context, {required TextStyle dayLetterTextStyle, required TextStyle dayNumberTextStyle, Color boxColor = Colors.transparent}) {
    return Container(
      height: 76,
      width: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(12.0),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            DateFormat('E').format(day)[0],
            style: dayLetterTextStyle,
          ),
          Text(
            '${day.day}',
            style: dayNumberTextStyle,
          ),
        ],
      ),
    );
  }
}
