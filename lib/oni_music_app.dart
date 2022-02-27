import 'package:flutter/material.dart';
import 'package:oni_music_player/src/presentation/base/router/oni_router.dart';
import 'package:oni_music_player/src/presentation/feature_search/router/search_router.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

class OniMusicApp extends StatefulWidget {
  final OniServiceLocator serviceLocator;

  const OniMusicApp({
    Key? key,
    required this.serviceLocator,
  }) : super(key: key);

  @override
  State<OniMusicApp> createState() => _OniMusicAppState();
}

class _OniMusicAppState extends State<OniMusicApp> {
  @override
  void dispose() {
    widget.serviceLocator.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
