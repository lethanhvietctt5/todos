import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todos/data_provider/todo_model.dart';
import 'package:todos/data_provider/todos_model.dart';
import 'package:todos/widgets/list_todos.dart';
import 'package:woozy_search/woozy_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<TodoModel> results = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosModel>(
      builder: (context, todos, child) {
        final wozzy = Woozy();
        for (TodoModel todo in todos.listTodos) {
          wozzy.addEntry(todo.title, value: todo.id);
        }

        void onChanged(newValue, index) {
          todos.removeTodo(results[index].id);
          setState(() {
            results.removeAt(index);
          });
        }

        if (_controller.value.text.isNotEmpty && results.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              elevation: 0,
              title: TextFormField(
                cursorColor: Colors.deepOrange,
                controller: _controller,
                onChanged: (value) {
                  final elements = wozzy.search(value);
                  List<int> ids = [];

                  for (dynamic e in elements) {
                    if (e.score > 0.3) {
                      ids.add(e.value);
                    }
                  }

                  List<TodoModel> _tempRes = [];
                  for (TodoModel todo in todos.listTodos) {
                    if (ids.contains(todo.id)) {
                      _tempRes.add(todo);
                    }
                  }
                  setState(() {
                    results = _tempRes;
                  });
                },
                autofocus: true,
                style: const TextStyle(color: Colors.black, fontSize: 13),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(bottom: 11, top: 11, right: 15),
                    hintText: "Search todos..."),
              ),
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white, // Status bar
              ),
            ),
            backgroundColor: Colors.white,
            body: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "asset/svg/ic_nodata.svg",
                      width: 200,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Cannot find any matches for your search term...",
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
            title: TextFormField(
              cursorColor: Colors.deepOrange,
              controller: _controller,
              onChanged: (value) {
                final elements = wozzy.search(value);
                List<int> ids = [];

                for (dynamic e in elements) {
                  if (e.score > 0.3) {
                    ids.add(e.value);
                  }
                }

                List<TodoModel> _tempRes = [];
                for (TodoModel todo in todos.listTodos) {
                  if (ids.contains(todo.id)) {
                    _tempRes.add(todo);
                  }
                }
                setState(() {
                  results = _tempRes;
                });
              },
              autofocus: true,
              style: const TextStyle(color: Colors.black, fontSize: 13),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 11, top: 11, right: 15),
                  hintText: "Search todos..."),
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white, // Status bar
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: ListTodo(list: results, callback: onChanged),
          ),
        );
      },
    );
  }
}
