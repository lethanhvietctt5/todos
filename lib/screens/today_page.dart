import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todos/data_provider/todo_model.dart';
import 'package:todos/data_provider/todos_model.dart';
import 'package:todos/helpers/convert_datetime.dart';
import 'package:todos/widgets/create_todo.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Today',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.grey[50],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            builder: (BuildContext builder) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 15),
                  height: 150,
                  child: const CreateToDo(),
                ),
              );
            },
            isScrollControlled: true,
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Consumer<TodosModel>(builder: (context, todos, child) {
          final todayTodos = todos.today as List<TodoModel>;
          if (todos.today.length == 0) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "asset/svg/ic_empty.svg",
                      width: 200,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        "You don't have any task to do...",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: ListView.builder(
              itemCount: todayTodos.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      todayTodos[index].title,
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
                            DateTimeHelper(todayTodos[index].dueDate).convertDateTimeToString(),
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    leading: Checkbox(
                      value: todayTodos[index].isDone,
                      onChanged: (newValue) {
                        todos.removeTodo(todayTodos[index].id);
                      },
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          );
        }),
      ),
    );
  }
}
