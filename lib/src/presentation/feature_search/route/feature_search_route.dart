import 'package:flutter/src/widgets/framework.dart';
import 'package:oni_music_player/src/presentation/base/route/base_route.dart';
import 'package:oni_music_player/src/presentation/feature_search/page/search_page.dart';

class FeatureSearchRoute extends BaseRoute {
  @override
  Map<String, WidgetBuilder> get routes => {
    '/': (context) => const SearchPage(),
  };
}
