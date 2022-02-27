import 'package:flutter/widgets.dart';
import 'package:oni_music_player/src/presentation/base/router/oni_router.dart';
import 'package:oni_music_player/src/presentation/feature_search/page/search_page.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

class SearchRouter extends OniRouter {
  @override
  Map<String, WidgetBuilder> get routes => {
        '/': (context) {
          return SearchPage(
            serviceLocator: OniServiceLocatorProvider.of(context),
          );
        },
      };
}
