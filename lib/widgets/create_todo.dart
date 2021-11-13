import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todos/data_provider/todo_model.dart';
import 'package:todos/data_provider/todos_model.dart';
import 'package:todos/helpers/convert_datetime.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'dart:math';

class CreateToDo extends StatefulWidget {
  const CreateToDo({Key? key}) : super(key: key);

  @override
  _CreateToDoState createState() => _CreateToDoState();
}

class _CreateToDoState extends State<CreateToDo> {
  String? _title;
  DateTime? _dueDate;

  final TextEditingController _titleController = TextEditingController();

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2021),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (time != null) {
        setState(() {
          _dueDate = DateTime(picked.year, picked.month, picked.day, time.hour, time.minute);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final todosModel = Provider.of<TodosModel>(context, listen: false);
    return Column(
      children: [
        TextField(
          controller: _titleController,
          onChanged: (value) {
            setState(() {
              _title = value;
            });
          },
          autofocus: true,
          maxLines: 3,
          style: const TextStyle(fontSize: 15),
          decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintText: "Enter todo here..."),
        ),
        Container(
          margin: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange[50],
                    elevation: 0,
                  ),
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'asset/svg/ic_clock.svg',
                        color: Colors.deepOrange,
                        width: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _dueDate != null ? DateTimeHelper(_dueDate as DateTime).convertDateTimeToString() : 'Set time',
                        style: const TextStyle(color: Colors.deepOrange, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (_title != null && _dueDate != null && _title != '') {
                    var rnd = Random();
                    var next = rnd.nextDouble() * 1000000000;
                    while (next < 100000000) {
                      next *= 10;
                    }
                    TodoModel obj = TodoModel(next.toInt(), _title as String, _dueDate as DateTime, false);
                    todosModel.addTodo(obj);
                    showTopSnackBar(
                      context,
                      const CustomSnackBar.success(
                        message: "Congratulation! Create a todo successful.",
                        backgroundColor: Colors.deepOrange,
                      ),
                    );
                    Navigator.pop(context);
                  } else if (_title == null || _title == '') {
                    showTopSnackBar(
                        context,
                        const CustomSnackBar.error(
                          message: "Ohhh...! Please enter todo.",
                          backgroundColor: Colors.orange,
                        ));
                  } else if (_dueDate == null) {
                    showTopSnackBar(
                        context,
                        const CustomSnackBar.error(
                          message: "Ohhh...! Please select duetime for todo.",
                          backgroundColor: Colors.orange,
                        ));
                  }
                },
                child: SvgPicture.asset(
                  "asset/svg/ic_add.svg",
                  color: Colors.deepOrange,
                  width: 30,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
