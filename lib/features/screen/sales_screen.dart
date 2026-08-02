import 'dart:math';

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
                  DropdownButton(
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
                            "${_salesController.dataUserSales[i]["user_name"]}",
                          ),
                        ),
                    ],
                    onChanged: (value) {
                      _salesController.itemUserSelected =
                          value ?? _salesController.itemUserSelected;
                      setState(() {});
                    },
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: [
                  Text("Product"),
                  DropdownButton(
                    value: _salesController.itemProductSelected,
                    items: [
                      for (
                        int i = 0;
                        i < _salesController.dataProductSales.length;
                        i++
                      )
                        DropdownMenuItem(
                          value:
                              _salesController.dataProductSales[i]["product_id"]
                                  as int,
                          child: Text(
                            "${_salesController.dataProductSales[i]["product_name"]}"
                            "  "
                            "${_salesController.dataProductSales[i]["price"]}"
                            "  "
                            "${_salesController.dataProductSales[i]["count"]}",
                          ),
                        ),
                    ],
                    onChanged: (value) {
                      _salesController.itemProductSelected =
                          value ?? _salesController.itemProductSelected;
                      setState(() {});
                    },
                  ),
                ],
              ),
              Row(
                spacing: 30,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _salesController.selectSales();
                      _salesController.selectTSales();
                      setState(() {});
                    },
                    child: Text("Refresh"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {});
                      int indexUser = _salesController.dataUserSales.indexWhere(
                        (element) =>
                            element["user_id"] ==
                            _salesController.itemUserSelected,
                      );
                      int indexProduct = _salesController.dataProductSales
                          .indexWhere(
                            (element) =>
                                element["product_id"] ==
                                _salesController.itemProductSelected,
                          );
                      // print(
                      //   _salesController.dataUserSales[indexUser]["user_name"],
                      // );
                      // print(
                      //   _salesController
                      //       .dataProductSales[indexProduct]["product_name"],
                      // );

                      await _salesController.insert(
                        userId:
                            // _salesController.itemUserSelected??0,
                            _salesController.dataUserSales[indexUser]["user_id"]
                                as int,
                        productId:
                            _salesController
                                    .dataProductSales[indexProduct]["product_id"]
                                as int,
                        // _salesController.itemProductSelected??0
                      );
                    },
                    child: Text("add"),
                  ),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        "User Name: ${_salesController.salesData[index]["user_name"]}",
                      ),
                      Text(
                        "Product name:${_salesController.salesData[index]["product_name"]}",
                      ),
                    ],
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: _salesController.salesData.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
