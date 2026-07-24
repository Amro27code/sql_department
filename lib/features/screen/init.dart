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
  late UserController _userController;

  @override
  void initState() {
    super.initState();
    _userController = UserController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // TextField(
            //   decoration: InputDecoration(
            //     label: Text("Enter your ...."),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(12),
            //       borderSide: BorderSide(color: Colors.blue),
            //     ),
            //   ),
            // ),
            ElevatedButton(
              onPressed:() {
                _userController.insertUser();
                _userController.selectUser();
                setState(() {
                });
              },
              child: Text("Inserted"),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _userController.selectUser,
              child: Text("Showing"),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: .spaceEvenly,
                  children: [
                    Text("${_userController.data[index]["user_id"]}"),
                    Text("${_userController.data[index]["user_name"]}"),
                  ],
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
