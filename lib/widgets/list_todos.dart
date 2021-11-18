import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todos/data_provider/todo_model.dart';

class ListTodo extends StatelessWidget {
  final List<TodoModel>? list;
  final Function(bool?, int)? callback;
  const ListTodo({Key? key, this.list, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: ListView.builder(
        itemCount: list != null ? list?.length : 0,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8,
            child: ListTile(
              title: Text(
                list![index].title,
                style: const TextStyle(fontSize: 15),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Container(
                margin: const EdgeInsets.only(top: 7),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: SvgPicture.asset(
                        "asset/svg/ic_clock.svg",
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      DateFormat.yMEd().add_jm().format(list![index].dueDate),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              leading: Checkbox(
                value: list![index].isDone,
                onChanged: (value) {
                  callback!(value, index);
                },
              ),
            ),
          );
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
