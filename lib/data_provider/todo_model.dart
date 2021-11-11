class TodoModel {
  final String _id;
  String _title;
  DateTime _dueDate;

  TodoModel(this._id, this._title, this._dueDate);

  String get id => _id;

  String get title => _title;
  set id(newTitle) {
    _title = newTitle;
  }

  DateTime get dueDate => _dueDate;
  set dueDate(newDueDate) => _dueDate = newDueDate;

  Map<String, dynamic> toJson() {
    return {'id': _id, 'title': _title, 'dueDate': _dueDate.microsecondsSinceEpoch.toString()};
  }

  static TodoModel fromJson(todo) {
    return TodoModel(todo['id'], todo['title'], DateTime.fromMicrosecondsSinceEpoch(int.parse(todo['dueDate'])));
  }

  int checkToday() {
    DateTime now = DateTime.now();
    return DateTime(_dueDate.year, _dueDate.month, _dueDate.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
}
