import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todos/helpers/convert_datetime.dart';

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
      firstDate: DateTime(1900),
      lastDate: DateTime(2022),
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
              hintText: "Enter title Todo here ..."),
        ),
        Container(
          margin: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
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
              SvgPicture.asset(
                "asset/svg/ic_add.svg",
                color: Colors.deepOrange,
                width: 30,
              ),
            ],
          ),
        )
      ],
    );
  }
}