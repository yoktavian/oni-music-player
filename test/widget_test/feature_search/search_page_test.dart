import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oni_music_player/src/core/service/service_locator_impl.dart';
import 'package:oni_music_player/src/data/feature_search/response/song_response.dart';
import 'package:oni_music_player/src/domain/base/organizer/oni_music_organizer.dart';
import 'package:oni_music_player/src/domain/feature_search/entity/song.dart';
import 'package:oni_music_player/src/domain/feature_search/repository/search_repository.dart';
import 'package:oni_music_player/src/presentation/feature_search/component/search_header_widget.dart';
import 'package:oni_music_player/src/presentation/feature_search/component/search_result_widget.dart';
import 'package:oni_music_player/src/presentation/feature_search/page/search_page.dart';

import '../../base/fake_data/fake_http_client.dart';
import '../../base/fake_data/fake_music_organizer.dart';
import '../../base/fake_data/fake_search_repository.dart';

void main() {
  final serviceLocator = ServiceLocatorImpl();

  testWidgets(
    'Given search page with no song playing '
    'When search page rendered '
    'Then all of components must be shown except music controller.',
    (tester) async {
      // given
      final response = SongResponse(
        2,
        [
          const Song(
            1,
            'rich-brian',
            10,
            'any-song',
            'any-album',
            'anyArtwork60',
            'anyArtwork100',
            'anyurl',
          ),
          const Song(
            1,
            'rich-brian',
            12,
            'any-song-1',
            'any-album',
            'anyArtwork60',
            'anyArtwork100',
            'anyurl',
          ),
        ],
      );

      serviceLocator
        ..registerFactory<SearchRepository>(
          () => FakeSearchRepository.success(
            Result.value(response),
          ),
        )
        ..registerFactory<OniMusicOrganizer>(
          () => FakeMusicOrganizer(),
        );

      // when
      await tester.pumpWidget(
        MaterialApp(
          home: SearchPage(serviceLocator: serviceLocator),
        ),
      );
      await tester.pumpAndSettle();

      // then
      final searchHeaderFinder = find.byKey(
        const Key(SearchPage.searchHeaderKey),
      );
      expect(searchHeaderFinder, findsOneWidget);

      final searchResultListFinder = find.byKey(
        const Key(SearchPage.searchResultListKey),
      );
      expect(searchResultListFinder, findsOneWidget);

      final searchMusicControllerFinder = find.byKey(
        const Key(SearchPage.searchMusicControllerKey),
      );
      expect(searchMusicControllerFinder, findsNothing);
      serviceLocator.clear();
    },
  );

  testWidgets(
    'Given search page with no song playing '
    'When perform search and get some result '
    'Then the song name, artist, album, image, play button must be shown and '
    'visualizer indicator must be hidden.',
    (tester) async {
      // given
      const firstSong = Song(
        1,
        'rich-brian',
        10,
        'any-song',
        'any-album',
        'anyArtwork60',
        'anyArtwork100',
        'anyurl',
      );

      final response = SongResponse(
        2,
        [
          firstSong,
          const Song(
            1,
            'rich-brian',
            12,
            'any-song-1',
            'any-album',
            'anyArtwork60',
            'anyArtwork100',
            'anyurl',
          ),
        ],
      );

      serviceLocator
        ..registerFactory<SearchRepository>(
          () => FakeSearchRepository.success(
            Result.value(response),
          ),
        )
        ..registerFactory<OniMusicOrganizer>(
          () => FakeMusicOrganizer(),
        );

      HttpOverrides.runWithHttpOverrides(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: SearchPage(serviceLocator: serviceLocator),
          ),
        );
        await tester.pumpAndSettle();

        // when perform search
        final searchTextFieldFinder = find.byKey(
          const Key(SearchHeaderWidget.searchTextFieldKey),
        );
        expect(searchTextFieldFinder, findsOneWidget);
        await tester.tap(searchTextFieldFinder);
        await tester.pumpAndSettle();
        // input any text doesn't matter, because we already fake the response.
        tester.testTextInput.enterText('any');
        await tester.pumpAndSettle();
        // perform go by clicking action on the keyboard.
        await tester.testTextInput.receiveAction(TextInputAction.go);
        await tester.pumpAndSettle();

        // search result must be shown.
        final firstSongFinder = find.byKey(
          Key(firstSong.trackId.toString()),
        );
        expect(firstSongFinder, findsOneWidget);

        final songNameFinder = find.descendant(
          of: firstSongFinder,
          matching: find.text(firstSong.trackName),
        );
        expect(songNameFinder, findsOneWidget);
        final artistNameFinder = find.descendant(
          of: firstSongFinder,
          matching: find.text(firstSong.artistName),
        );
        expect(artistNameFinder, findsOneWidget);
        final albumFinder = find.descendant(
          of: firstSongFinder,
          matching: find.text(firstSong.collectionName),
        );
        expect(albumFinder, findsOneWidget);
        final playButtonFinder = find.descendant(
          of: firstSongFinder,
          matching: find.byKey(const Key(SearchResultWidget.playButtonKey)),
        );
        expect(playButtonFinder, findsOneWidget);
        // must be hidden because no one song playing.
        final visualizerIndicatorFinder = find.descendant(
          of: firstSongFinder,
          matching: find.byKey(
            const Key(SearchResultWidget.visualizerIndicatorKey),
          ),
        );
        expect(visualizerIndicatorFinder, findsNothing);
        serviceLocator.clear();
      }, FakeHttpOverrides());
    },
  );

  testWidgets(
    'Given some song '
    'When play one of the song '
    'Then the visualizer animation indicator and music controller must be shown.',
    (tester) async {
      // given
      const firstSong = Song(
        1,
        'rich-brian',
        10,
        'any-song',
        'any-album',
        'anyArtwork60',
        'anyArtwork100',
        'anyurl',
      );

      final response = SongResponse(
        2,
        [
          firstSong,
          const Song(
            1,
            'rich-brian',
            12,
            'any-song-1',
            'any-album',
            'anyArtwork60',
            'anyArtwork100',
            'anyurl',
          ),
        ],
      );

      serviceLocator
        ..registerFactory<SearchRepository>(
          () => FakeSearchRepository.success(
            Result.value(response),
          ),
        )
        ..registerFactory<OniMusicOrganizer>(
          () => FakeMusicOrganizer(),
        );

      HttpOverrides.runWithHttpOverrides(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: SearchPage(serviceLocator: serviceLocator),
          ),
        );
        await tester.pumpAndSettle();

        // when perform search
        final searchTextFieldFinder = find.byKey(
          const Key(SearchHeaderWidget.searchTextFieldKey),
        );
        expect(searchTextFieldFinder, findsOneWidget);
        await tester.tap(searchTextFieldFinder);
        await tester.pumpAndSettle();
        // input any text doesn't matter, because we already fake the response.
        tester.testTextInput.enterText('any');
        await tester.pumpAndSettle();
        // perform go by clicking action on the keyboard.
        await tester.testTextInput.receiveAction(TextInputAction.go);
        await tester.pumpAndSettle();

        // search result must be shown.
        final firstSongFinder = find.byKey(
          Key(firstSong.trackId.toString()),
        );
        expect(firstSongFinder, findsOneWidget);

        final playButtonFinder = find.descendant(
          of: firstSongFinder,
          matching: find.byKey(const Key(SearchResultWidget.playButtonKey)),
        );
        expect(playButtonFinder, findsOneWidget);
        await tester.tap(playButtonFinder);
        // use pump because there is an animation when the song is played,
        // if we're using pump and settle it will be time out because our
        // animation always running so it can't be settled.
        await tester.pump();

        final visualizerIndicatorFinder = find.byKey(
          const Key(SearchResultWidget.visualizerIndicatorKey),
        );
        expect(visualizerIndicatorFinder, findsOneWidget);

        final musicControllerFinder = find.byKey(
          const Key(SearchPage.searchMusicControllerKey),
        );
        expect(musicControllerFinder, findsOneWidget);
        serviceLocator.clear();
      }, FakeHttpOverrides());
    },
  );
}
