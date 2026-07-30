import 'package:flutter/material.dart';
import 'package:sqflite_department/controller/product_controller.dart';
import 'package:sqflite_department/sqlite/my_sqflite_database.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductController _productController;

  @override
  void initState() {
    super.initState();
    _productController = ProductController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(centerTitle: true, title: Text("Product Screen")),
      body: Padding(
        padding: const EdgeInsetsGeometry.all(16),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            TextField(
              controller: _productController.productNameController,
              decoration: InputDecoration(
                label: Text("Enter your user name"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            TextField(
              controller: _productController.productPriceController,
              keyboardType: .number,
              decoration: InputDecoration(
                label: Text("Enter your price"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            TextField(
              controller: _productController.productCountController,
              keyboardType: .number,
              decoration: InputDecoration(
                label: Text("Enter your count"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // _productController.mySqflite.delete();
                _productController.insert();
                _productController.select();
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
                    int id =
                        _productController.data[index]["product_id"] as int;

                    _productController.productEditNameController.text =
                    _productController.data[index]["product_name"].toString();

                    _productController.productEditCountController.text =
                    _productController.data[index]["count"].toString();

                    _productController.productEditPriceController.text =
                    _productController.data[index]["price"].toString();
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextField(
                              controller:
                                  _productController.productEditNameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                            ),
                            TextField(
                              controller:
                                  _productController.productEditCountController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                              ),
                            ),
                            TextField(
                              controller:
                                  _productController.productEditPriceController,
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
                                    _productController.update(
                                      name: _productController
                                          .productEditNameController
                                          .text
                                          .toString(),
                                      price:
                                          double.parse(
                                            _productController
                                                .productEditPriceController
                                                .text
                                                // .toString(),
                                          ) ,
                                      count:
                                          int.parse(
                                            _productController
                                                .productEditCountController
                                                .text
                                                // .toString(),
                                          ) ,
                                      id: id,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Update"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _productController.delete(id: id);
                                    _productController.select();
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
                      Text("${_productController.data[index]["product_id"]}"),
                      Text("${_productController.data[index]["product_name"]}"),
                      Text("${_productController.data[index]["price"]}"),
                      Text("${_productController.data[index]["count"]}"),
                    ],
                  ),
                ),
                itemCount: _productController.data.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
