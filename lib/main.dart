import 'package:flutter/material.dart';
import 'package:oni_music_player/oni_music_app.dart';
import 'package:oni_music_player/src/core/service/service_locator_impl.dart';
import 'package:oni_music_player/src/core/service/service_locator_provider.dart';
import 'package:oni_music_player/src/data/base/organizer/oni_music_organizer_impl.dart';
import 'package:oni_music_player/src/data/feature_search/repository/search_repository_impl.dart';
import 'package:oni_music_player/src/domain/base/organizer/oni_music_organizer.dart';
import 'package:oni_music_player/src/domain/feature_search/repository/search_repository.dart';

void main() async {
  final serviceLocator = ServiceLocatorImpl();
  await _initializeServiceFactory(serviceLocator);

  runApp(
    ServiceLocatorProvider(
      serviceLocator: serviceLocator,
      child: OniMusicApp(
        serviceLocator: serviceLocator,
      ),
    ),
  );
}

Future<void> _initializeServiceFactory(
  ServiceLocatorImpl serviceLocator,
) async {
  serviceLocator
    ..registerFactory<SearchRepository>(
      () => SearchRepositoryImpl(),
    )
    ..registerFactory<OniMusicOrganizer>(
      () => OniMusicOrganizerImpl(),
    );
}
