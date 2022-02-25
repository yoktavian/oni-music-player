import 'package:flutter/widgets.dart';

abstract class OniRouter {
  abstract final Map<String, WidgetBuilder> routes;

  static pushName(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }
}
