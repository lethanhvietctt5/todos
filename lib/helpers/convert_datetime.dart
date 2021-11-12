class DateTimeHelper {
  final DateTime _dateTime;

  DateTimeHelper(this._dateTime);

  String convertTimeToString() {
    return '${_dateTime.hour.toString().padLeft(2, "0")}:${_dateTime.minute.toString().padLeft(2, "0")}';
  }

  String convertDateTimeToString() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    DateTime checkDate = DateTime(_dateTime.year, _dateTime.month, _dateTime.day);

    if (checkDate == today) {
      return '${convertTimeToString()}, Today';
    } else if (checkDate == yesterday) {
      return '${convertTimeToString()}, Yesterday';
    } else if (checkDate == tomorrow) {
      return '${convertTimeToString()}, Tomorrow';
    } else if (now.year == _dateTime.year) {
      return '${convertTimeToString()}, ${_dateTime.day.toString().padLeft(2, "0")}/${_dateTime.month.toString().padLeft(2, "0")}';
    } else {
      return '${convertTimeToString()}, ${_dateTime.day.toString().padLeft(2, "0")}/${_dateTime.month.toString().padLeft(2, "0")}/${_dateTime.year}';
    }
  }
}
