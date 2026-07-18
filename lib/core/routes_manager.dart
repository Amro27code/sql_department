import 'package:flutter/material.dart';

import '../features/screen/init.dart';

class RoutesManager {
  static final Map<String, WidgetBuilder> route = {
    RouteNames.init: (context) => const Init(),
  };
}

class RouteNames {
  static const String init = "Init";
}
