import 'package:flutter_test/flutter_test.dart';
import 'package:async/async.dart';
import 'package:oni_music_player/src/data/feature_search/response/song_response.dart';
import 'package:oni_music_player/src/domain/base/organizer/oni_music_organizer.dart';
import 'package:oni_music_player/src/domain/feature_search/entity/song.dart';
import 'package:oni_music_player/src/presentation/feature_search/presenter/search_presenter.dart';

import '../../base/fake_data/fake_search_repository.dart';

void main() {
  test(
    'Given some fake song response, '
    'When emit search event, '
    'Then the state must be updated according to the response.',
    () async {
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

      final searchPresenter = SearchPresenter(
        FakeSearchRepository.success(Result.value(response)),
      );

      // when
      searchPresenter.emit(SearchSongEvent('rich-brian'));

      // then
      await Future.delayed(
        const Duration(milliseconds: 50),
        () {
          expect(
            searchPresenter.state.value.songs,
            response.results,
          );
        },
      );
    },
  );

  test(
    'Given one song to be played, '
    'When emit played song event, '
    'Then the value of playedSong in state must be '
    'updated according to selected song.',
    () async {
      // given
      const selectedSong = Song(
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
          selectedSong,
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

      final searchPresenter = SearchPresenter(
        FakeSearchRepository.success(Result.value(response)),
      );

      // when
      searchPresenter.emit(PlaySongEvent(selectedSong));

      // then
      expect(
        searchPresenter.state.value.playedSong,
        selectedSong,
      );
    },
  );

  test(
    'When emit stop playing song event, '
    'Then the value of playedSong in state must be reset to null.',
    () async {
      // given
      final response = SongResponse(
        1,
        [
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

      final searchPresenter = SearchPresenter(
        FakeSearchRepository.success(Result.value(response)),
      );

      // when
      searchPresenter.emit(StopSongPlayingEvent());

      // then
      expect(
        searchPresenter.state.value.playedSong,
        null,
      );
    },
  );

  test(
    'When emit pause song event, '
    'Then the state value must be the same with the previous one',
    () async {
      // given
      final response = SongResponse(
        1,
        [
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

      final searchPresenter = SearchPresenter(
        FakeSearchRepository.success(Result.value(response)),
      );

      final currentState = searchPresenter.state;

      // when
      searchPresenter.emit(PauseSongPlayingEvent());

      // then
      expect(
        currentState.value.playedSong,
        searchPresenter.state.value.playedSong,
      );
      expect(
        currentState.value.songs,
        searchPresenter.state.value.songs,
      );
    },
  );

  test(
    'When emit resume song event, '
    'Then the state value must be the same with the previous one',
    () async {
      // given
      final response = SongResponse(
        1,
        [
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

      final searchPresenter = SearchPresenter(
        FakeSearchRepository.success(Result.value(response)),
      );

      final currentState = searchPresenter.state;

      // when
      searchPresenter.emit(ResumeSongPlayingEvent());

      // then
      expect(
        currentState.value.playedSong,
        searchPresenter.state.value.playedSong,
      );
      expect(
        currentState.value.songs,
        searchPresenter.state.value.songs,
      );
    },
  );

  test(
    'When emit on music player state changed event with non completed state, '
    'Then the state value must be the same with the previous one',
    () async {
      // given
      final response = SongResponse(
        1,
        [
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

      final searchPresenter = SearchPresenter(
        FakeSearchRepository.success(Result.value(response)),
      );

      final currentState = searchPresenter.state;

      // when
      searchPresenter.emit(OnMusicPlayerStateChangedEvent(OniMusicState.pause));

      // then
      expect(
        currentState.value.playedSong,
        searchPresenter.state.value.playedSong,
      );
      expect(
        currentState.value.songs,
        searchPresenter.state.value.songs,
      );
    },
  );

  test(
    'Given one song played, '
    'When completed played and emit on music player state changed event with '
    'completed state, '
    'Then the playedSong state must be reset to null',
    () async {
      // given
      final response = SongResponse(
        1,
        [
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

      final searchPresenter = SearchPresenter(
        FakeSearchRepository.success(Result.value(response)),
      );
      searchPresenter.emit(SearchSongEvent('any'));
      // simulate future delay from api request.
      await Future.delayed(
        const Duration(milliseconds: 50),
            () {
          searchPresenter.emit(PlaySongEvent(response.results.first));
        },
      );
      // when playing a song, the state of playedSong must be not null.
      expect(
        searchPresenter.state.value.playedSong,
        response.results.first,
      );

      // when
      searchPresenter.emit(
        OnMusicPlayerStateChangedEvent(OniMusicState.completed),
      );

      // then
      expect(
        searchPresenter.state.value.playedSong,
        null,
      );
    },
  );

  test(
    'Given first song played, '
    'When emit skip to previous event '
    'Then should do nothing, the state must be the same with the previous',
    () async {
      // given
      final response = SongResponse(
        1,
        [
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

      final searchPresenter = SearchPresenter(
        FakeSearchRepository.success(Result.value(response)),
      );
      searchPresenter.emit(SearchSongEvent('any'));
      // simulate future delay from api request.
      await Future.delayed(
        const Duration(milliseconds: 50),
        () {
          searchPresenter.emit(PlaySongEvent(response.results.first));
        },
      );
      final currentState = searchPresenter.state;

      // when
      searchPresenter.emit(SkipToPreviousSongEvent());

      // then
      expect(currentState, searchPresenter.state);
    },
  );

  test(
    'Given second song played, '
    'When emit skip to the previous song event '
    'Then should play the first order of the song.',
    () async {
      // given
      final response = SongResponse(
        1,
        [
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
          const Song(
            12,
            'rich-brian',
            4,
            'any-song-1',
            'any-album',
            'anyArtwork60',
            'anyArtwork100',
            'anyurl',
          ),
        ],
      );

      final searchPresenter = SearchPresenter(
        FakeSearchRepository.success(Result.value(response)),
      );
      searchPresenter.emit(SearchSongEvent('any'));
      // simulate future delay from api request.
      await Future.delayed(
        const Duration(milliseconds: 50),
        () {
          // simulate second song selected.
          searchPresenter.emit(PlaySongEvent(response.results[1]));
        },
      );
      final currentSongPlaying = searchPresenter.state.value.playedSong;

      // when
      searchPresenter.emit(SkipToPreviousSongEvent());
      final newSongPlaying = searchPresenter.state.value.playedSong;

      // then
      expect(currentSongPlaying != newSongPlaying, true);
      expect(newSongPlaying == searchPresenter.state.value.songs.first, true);
    },
  );

  test(
    'Given first song played, '
    'When emit skip to the next song event '
    'Then should play the second order of the song.',
    () async {
      // given
      final response = SongResponse(
        1,
        [
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
          const Song(
            12,
            'rich-brian',
            4,
            'any-song-1',
            'any-album',
            'anyArtwork60',
            'anyArtwork100',
            'anyurl',
          ),
        ],
      );

      final searchPresenter = SearchPresenter(
        FakeSearchRepository.success(Result.value(response)),
      );
      searchPresenter.emit(SearchSongEvent('any'));
      // simulate future delay from api request.
      await Future.delayed(
        const Duration(milliseconds: 50),
        () {
          // simulate second song selected.
          searchPresenter.emit(PlaySongEvent(response.results.first));
        },
      );
      final currentSongPlaying = searchPresenter.state.value.playedSong;

      // when
      searchPresenter.emit(SkipToNextSongEvent());
      final newSongPlaying = searchPresenter.state.value.playedSong;

      // then
      expect(currentSongPlaying != newSongPlaying, true);
      expect(newSongPlaying == searchPresenter.state.value.songs[1], true);
    },
  );
}
