import 'package:flutter/material.dart';
import 'package:sqflite_department/controller/sales_controller.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  late SalesController _salesController;

  @override
  void initState() {
    super.initState();
    _salesController = SalesController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Sales screen")),
      body: FutureBuilder(
        future: _salesController.selectUser(),
        builder: (context, snapshot) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: Column(
            // mainAxisAlignment: .center,
            children: [
              Row(
                spacing: 10,
                children: [
                  Text("Users"),
                  (_salesController.dataUserSales.isEmpty ||
                          _salesController.dataUserSales == null)
                      ? SizedBox()
                      : DropdownButton(
                          value: _salesController.itemUserSelected,
                          items: [
                            for (
                              int i = 0;
                              i < _salesController.dataUserSales.length;
                              i++
                            )
                              DropdownMenuItem(
                                value:
                                    _salesController.dataUserSales[i]["user_id"]
                                        as int,
                                child: Text(
                                  _salesController
                                      .dataUserSales[i]["user_name"],
                                ),
                              ),
                          ],
                          onChanged: (value) {
                            _salesController.itemUserSelected =
                                value ?? _salesController.itemUserSelected;
                            // print(_salesController.itemUserSelected);
                            // print(value);
                            // print("---------");
                            setState(() {});
                          },
                        ),
                ],
              ),
              Row(
                spacing: 10,
                children: [
                  Text("Product"),
                  (_salesController.dataProductSales.isEmpty ||
                          _salesController.dataProductSales == null)
                      ? SizedBox()
                      : DropdownButton(
                          value: _salesController.itemProductSelected,
                          items: [
                            for (
                              int i = 0;
                              i < _salesController.dataProductSales.length;
                              i++
                            )
                              DropdownMenuItem(
                                value:
                                    _salesController
                                            .dataProductSales[i]["product_id"]
                                        as int,
                                child: Text(
                                  _salesController
                                          .dataProductSales[i]["product_name"] +
                                      "  " +
                                      "${_salesController.dataProductSales[i]["price"]}" +
                                      "  " +
                                      "${_salesController.dataProductSales[i]["count"]}",
                                ),
                              ),
                          ],
                          onChanged: (value) {
                            _salesController.itemProductSelected =
                                value ?? _salesController.itemProductSelected;
                            // print(_salesController.itemProductSelected);
                            // print(value);
                            // print("---------");
                            setState(() {});
                          },
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
