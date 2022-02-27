import 'package:flutter/widgets.dart';
import 'package:oni_music_player/src/core/service_locator/service_locator_provider.dart';
import 'package:oni_music_player/src/domain/feature_search/repository/search_repository.dart';
import 'package:oni_music_player/src/presentation/base/router/oni_router.dart';
import 'package:oni_music_player/src/presentation/feature_search/page/search_page.dart';

class SearchRouter extends OniRouter {
  @override
  Map<String, WidgetBuilder> get routes => {
    '/': (context) {
      final serviceLocator = ServiceLocatorProvider.of(context);
      return SearchPage(
        repository: serviceLocator.getIt<SearchRepository>(),
      );
    },
  };
}
