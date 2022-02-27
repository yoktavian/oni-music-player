import 'package:flutter/material.dart';
import 'package:oni_music_player/oni_music_app.dart';
import 'package:oni_music_player/src/core/service_locator/service_locator_impl.dart';
import 'package:oni_music_player/src/core/service_locator/service_locator_provider.dart';
import 'package:oni_music_player/src/data/feature_search/repository/search_repository_impl.dart';
import 'package:oni_music_player/src/domain/feature_search/repository/search_repository.dart';

void main() {
  final serviceLocator = ServiceLocatorImpl();
  _initializeServiceFactory(serviceLocator);

  runApp(
    ServiceLocatorProvider(
      serviceLocator: serviceLocator,
      child: OniMusicApp(
        serviceLocator: serviceLocator,
      ),
    ),
  );
}

void _initializeServiceFactory(ServiceLocatorImpl serviceLocator) {
  serviceLocator.registerFactory<SearchRepository>(
    () => SearchRepositoryImpl(),
  );
}
