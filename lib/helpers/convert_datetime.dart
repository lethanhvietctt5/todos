class DateTimeHelper {
  DateTime _dateTime;

  DateTimeHelper(this._dateTime);

  String convertTimeToString() {
    return '${_dateTime.hour.toString().padLeft(2, "0")}:${_dateTime.minute.toString().padLeft(2, "0")}';
  }
}
