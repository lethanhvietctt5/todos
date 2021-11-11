import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todos/widgets/create_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
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
          icon: const Icon(Icons.add),
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/all');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 15),
                        child: SvgPicture.asset(
                          "asset/svg/ic_all.svg",
                          width: 30,
                          color: Colors.red[800],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "All",
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "2",
                              style: TextStyle(fontSize: 15, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/today');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 15),
                        child: SvgPicture.asset(
                          "asset/svg/ic_today.svg",
                          width: 30,
                          color: Colors.green[800],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Today",
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "2",
                              style: TextStyle(fontSize: 15, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/upcomming');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 15),
                        child: SvgPicture.asset(
                          "asset/svg/ic_upcomming.svg",
                          width: 30,
                          color: Colors.purple[800],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Upcomming",
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "2",
                              style: TextStyle(fontSize: 15, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
