import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class TableCalendarWidget extends StatefulWidget {
  final CalendarFormat calendarFormat;
  TableCalendarWidget({this.calendarFormat});
  String selectedDay;

  @override
  _TableCalendarWidgetState createState() => _TableCalendarWidgetState();
}

class _TableCalendarWidgetState extends State<TableCalendarWidget> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<Event>> selectedEvents;

  List<Event> _getEventsForDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: "tr",
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      shouldFillViewport: false,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarFormat: widget.calendarFormat,
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        selectedDecoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(minCurved),
        ),
        outsideDecoration: boxDecoration,
        defaultDecoration: boxDecoration,
        weekendDecoration: boxDecoration,
        selectedTextStyle: TextStyle(
          color: Colors.white,
        ),
        todayDecoration: BoxDecoration(
          color: secondaryColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(minCurved),
        ),
      ),
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {          
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;     
        });
      },
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      eventLoader: _getEventsForDay,
    );
  }
}

class Event {
  final String operation;
  Event({this.operation});

  String toString() => this.operation;
}
