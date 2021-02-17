import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(BuildContext context, String dateTimeString) {
  var _dateTime = DateTime.parse(dateTimeString);
  var _timeOfDay = TimeOfDay.fromDateTime(_dateTime);

  String _weekDay = DateFormat('EEE').format(_dateTime);
  String _day = DateFormat('d').format(_dateTime);
  String _month = DateFormat('MMMM').format(_dateTime);
  String _time = _timeOfDay.format(context);
  String formattedDate = '$_weekDay' + '—' + '$_day' + ' $_month at $_time';

  return formattedDate;
}
