import 'package:flutter/material.dart';
import 'package:oni_music_player/src/presentation/base/router/oni_router.dart';
import 'package:oni_music_player/src/presentation/feature_search/router/search_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: _populateRoutes([
        SearchRouter(),
      ]),
    );
  }

  Map<String, Widget Function(BuildContext)> _populateRoutes(
    List<OniRouter> route,
  ) {
    final Map<String, Widget Function(BuildContext)> routes = {};
    for (var router in route) {
      routes.addAll(router.routes);
    }
    return routes;
  }
}
