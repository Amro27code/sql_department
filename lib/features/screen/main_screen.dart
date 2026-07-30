import 'package:flutter/material.dart';
import 'package:sqflite_department/core/routes_manager.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: .center,
        spacing: 15,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteNames.init);
            },
            child: Text("User Screen"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteNames.product);
            },
            child: Text("Product Screen"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteNames.sales);
            },
            child: Text("Sales Screen"),
          ),
        ],
      ),
    );
  }
}
