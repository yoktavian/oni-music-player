import 'package:flutter/material.dart';
import 'package:oni_music_player/oni_music_app.dart';
import 'package:oni_music_player/src/data/base/organizer/oni_music_organizer_impl.dart';
import 'package:oni_music_player/src/data/feature_search/repository/search_repository_impl.dart';
import 'package:oni_music_player/src/domain/base/organizer/oni_music_organizer.dart';
import 'package:oni_music_player/src/domain/feature_search/repository/search_repository.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

void main() async {
  final serviceLocator = OniServiceLocatorImpl();
  await _initializeServiceFactory(serviceLocator);

  runApp(
    OniServiceLocatorProvider(
      serviceLocator: serviceLocator,
      child: OniMusicApp(
        serviceLocator: serviceLocator,
      ),
    ),
  );
}

Future<void> _initializeServiceFactory(
  OniServiceLocator serviceLocator,
) async {
  serviceLocator
    ..registerFactory<SearchRepository>(
      () => SearchRepositoryImpl(),
    )
    ..registerFactory<OniMusicOrganizer>(
      () => OniMusicOrganizerImpl(),
    );
}
