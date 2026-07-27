import 'package:flutter/material.dart';
import 'package:sqflite_department/features/screen/main_screen.dart';
import 'package:sqflite_department/features/screen/product_screen.dart';

import '../features/screen/init.dart';

class RoutesManager {
  static final Map<String, WidgetBuilder> route = {
    RouteNames.main: (context) => const MainScreen(),
    RouteNames.init: (context) => const Init(),
    RouteNames.product: (context) => const ProductScreen(),
    // RouteNames.init: (context) => const Init(),
  };
}

class RouteNames {
  static const String main = "Main";
  static const String init = "Init";
  static const String product = "Product";
  static const String sales = "Sales";
}
