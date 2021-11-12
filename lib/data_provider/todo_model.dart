class TodoModel {
  final int _id;
  String _title;
  DateTime _dueDate;
  bool _isDone;

  TodoModel(this._id, this._title, this._dueDate, this._isDone);

  int get id => _id;

  String get title => _title;
  set id(newTitle) {
    _title = newTitle;
  }

  DateTime get dueDate => _dueDate;
  set dueDate(newDueDate) => _dueDate = newDueDate;

  bool get isDone => _isDone;
  set isDone(newIsDone) => _isDone = newIsDone;

  Map<String, dynamic> toJson() {
    return {'id': _id, 'title': _title, 'dueDate': _dueDate.microsecondsSinceEpoch.toString(), 'isDone': _isDone};
  }

  static TodoModel fromJson(todo) {
    return TodoModel(
        todo['id'], todo['title'], DateTime.fromMicrosecondsSinceEpoch(int.parse(todo['dueDate'])), todo['isDone']);
  }

  int checkToday() {
    DateTime now = DateTime.now();
    return DateTime(_dueDate.year, _dueDate.month, _dueDate.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
}
