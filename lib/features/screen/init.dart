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
  late ProductController _userController;

  @override
  void initState() {
    super.initState();
    _userController = ProductController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Product Screen"),),
      body: Padding(
        padding: const EdgeInsetsGeometry.all(16),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            TextField(
              controller: _userController.userNameController,
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
                // _userController.mySqflite.delete();
                _userController.insertUser();
                _userController.selectUser();
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
                    int id = _userController.data[index]["user_id"] as int;
                    _userController.userNameEditController.text =
                        "${_userController.data[index]["user_name"]}";
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextField(
                              controller:
                                  _userController.userNameEditController,
                              decoration: InputDecoration(
                                // label: Text(
                                //   "${_userController.data[index]["user_name"]}",
                                // ),
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
                                    _userController.updateUser(
                                      name: _userController
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
                                    _userController.deleteFromUser(id: id);
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
                      Text("${_userController.data[index]["user_id"]}"),
                      Text("${_userController.data[index]["user_name"]}"),
                    ],
                  ),
                ),
                itemCount: _userController.data.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
