import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todos/data_provider/todo_model.dart';
import 'package:todos/data_provider/todos_model.dart';
import 'package:todos/helpers/convert_datetime.dart';

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
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Consumer<TodosModel>(builder: (context, todos, child) {
          final todayTodos = todos.today as List<TodoModel>;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ListView.builder(
              itemCount: todayTodos.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      todayTodos[index].title,
                      style: const TextStyle(fontSize: 15),
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
                      value: false,
                      onChanged: (newValue) {},
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
