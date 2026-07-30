import 'package:flutter/material.dart';
import 'package:sqflite_department/controller/user_controller.dart';
import 'package:sqflite_department/sqlite/my_sqflite_database.dart';

class Init extends StatefulWidget {
  const Init({super.key});

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init> {
  // TextEditingController userNameController = TextEditingController();
  // List<Map<String, Object?>> data = [];
  late ProductController _;

  @override
  void initState() {
    super.initState();
    _ = ProductController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("User Screen"),),
      body: Padding(
        padding: const EdgeInsetsGeometry.all(16),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            TextField(
              controller: _.userNameController,
              decoration: InputDecoration(
                label: Text("Enter your user name"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // _.mySqflite.delete();
                _.insertUser();
                _.selectUser();
                setState(() {});
              },
              child: Text("Inserted"),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text("Refresh"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    int id = _.data[index]["user_id"] as int;
                    _.userNameEditController.text =
                        "${_.data[index]["user_name"]}";
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextField(
                              controller:
                                  _.userNameEditController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _.updateUser(
                                      name: _
                                          .userNameEditController
                                          .text
                                          .toString(),
                                      id: id,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Update"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _.deleteFromUser(id: id);
                                    setState(() {});
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Delete"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: .spaceEvenly,
                    children: [
                      Text("${_.data[index]["user_id"]}"),
                      Text("${_.data[index]["user_name"]}"),
                    ],
                  ),
                ),
                itemCount: _.data.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
