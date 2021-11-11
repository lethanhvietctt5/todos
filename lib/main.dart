import 'package:flutter/material.dart';
import 'package:todos/screens/all_page.dart';
import 'package:todos/screens/home_page.dart';
import 'package:todos/screens/today_page.dart';
import 'package:todos/screens/upcomming_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          default:
            return MaterialPageRoute(builder: (_) => const HomePage());
        }
      },
    );
  }
}
