import 'package:flutter/material.dart';
import 'package:lumiere/app/modules/home/domain/entities/movie_entity.dart';
import 'package:lumiere/app/shared/core/styles/core.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime selectedDay;
  final Function loaderEvent;
  final Function onDaySelected;
  final CalendarFormat format;

  const CalendarWidget(
      {super.key,
      required this.selectedDay,
      required this.loaderEvent,
      required this.onDaySelected,
      required this.format});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        locale: 'pt_BR',
        firstDay: DateTime.utc(2023, 4, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: widget.selectedDay,
        calendarFormat: widget.format,
        
        calendarStyle: const CalendarStyle(
          isTodayHighlighted: false,
          outsideDaysVisible: false,
          markersAlignment: Alignment.bottomRight,
        ),
        headerStyle:
            const HeaderStyle(formatButtonVisible: false, titleCentered: true),
        selectedDayPredicate: (day) {
          return isSameDay(widget.selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) =>
            widget.onDaySelected(selectedDay, focusedDay)

        // {
        //   homeBloc.showMoviesPerDay(selectedDay);
        //   setState(() {
        //     _selectedDay = selectedDay;
        //   });
        // },
        );
  }

  Widget? getEventCounter(List<Object?> events) {
    events as List<HomeMovieEntity?>;
    int size =
        events.where((event) => event!.hasViewer == false).toList().length;

    if (size > 0) {
      return Container(
        width: 16,
        height: 16,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: BorderRadius.circular(16)),
        child: Text(
          '$size',
          style: AppTextStyles.textBoldH10
              .apply(color: Theme.of(context).colorScheme.onSurface),
        ),
      );
    }
    return const SizedBox();
  }
}
