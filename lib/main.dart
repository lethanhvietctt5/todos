import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/data_provider/todos_model.dart';
import 'package:todos/screens/all_page.dart';
import 'package:todos/screens/home_page.dart';
import 'package:todos/screens/search_page.dart';
import 'package:todos/screens/today_page.dart';
import 'package:todos/screens/upcomming_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todos App',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: const HomePage(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => const HomePage());
            case '/today':
              return MaterialPageRoute(builder: (_) => const TodayPage());
            case '/all':
              return MaterialPageRoute(builder: (_) => const AllPage());
            case '/upcomming':
              return MaterialPageRoute(builder: (_) => const UpcommingPage());
            case '/search':
              return MaterialPageRoute(builder: (_) => const SearchPage());
            default:
              return MaterialPageRoute(builder: (_) => const HomePage());
          }
        },
      ),
    );
  }
}
