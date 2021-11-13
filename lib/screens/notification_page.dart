import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todos/data_provider/todo_model.dart';
import 'package:todos/data_provider/todos_model.dart';
import 'package:todos/helpers/convert_datetime.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white, // Status bar
        ),
      ),
      backgroundColor: Colors.white,
      body: Consumer<TodosModel>(
        builder: (context, todos, child) {
          List<TodoModel> notifications = [];
          for (TodoModel todo in todos.listTodos) {
            if (todo.dueDate.difference(DateTime.now()).inMinutes < 10) {
              notifications.add(todo);
            }
          }

          notifications = notifications.reversed.toList();
          if (notifications.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "asset/svg/ic_notify.svg",
                      width: 200,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        "You don't have any notifications...",
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                    "*Remove notifications is mean mark todo as done",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
                ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 8,
                      child: ListTile(
                        title: Text(
                          notifications[index].title,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Container(
                          margin: const EdgeInsets.only(top: 7),
                          child: Text(
                            DateTimeHelper(notifications[index].dueDate).convertDateTimeToString(),
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        trailing: InkWell(
                          child: SvgPicture.asset(
                            'asset/svg/ic_remove.svg',
                            color: Colors.red,
                            width: 20,
                            height: 20,
                          ),
                          onTap: () {
                            todos.removeTodo(notifications[index].id);
                          },
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
