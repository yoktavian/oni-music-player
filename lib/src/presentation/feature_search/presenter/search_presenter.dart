import 'package:flutter/widgets.dart';
import 'package:oni_music_player/src/domain/base/organizer/oni_music_organizer.dart';
import 'package:oni_music_player/src/domain/feature_search/entity/song.dart';
import 'package:oni_music_player/src/domain/feature_search/repository/search_repository.dart';
import 'package:oni_music_player/src/presentation/base/presenter/oni_presenter.dart';
import 'package:async/async.dart';

class SearchState {
  List<Song> songs;

  Song? playedSong;

  SearchState({this.songs = const [], this.playedSong});

  SearchState copy({
    List<Song>? songs,
    Song? playedSong,
  }) {
    return SearchState(
      songs: songs ?? this.songs,
      playedSong: playedSong ?? this.playedSong,
    );
  }
}

abstract class SearchEvent {}

class SearchSongEvent extends SearchEvent {
  final String artistName;

  SearchSongEvent(this.artistName);
}

class PlaySongEvent extends SearchEvent {
  final Song track;

  PlaySongEvent(this.track);
}

class StopSongPlayingEvent extends SearchEvent {}

class PauseSongPlayingEvent extends SearchEvent {}

class ResumeSongPlayingEvent extends SearchEvent {}

class SkipToPreviousSongEvent extends SearchEvent {}

class SkipToNextSongEvent extends SearchEvent {}

class OnMusicPlayerStateChangedEvent extends SearchEvent {
  final OniMusicState state;

  OnMusicPlayerStateChangedEvent(this.state);
}

class SearchPresenter extends OniPresenter<SearchState, SearchEvent> {
  final SearchRepository _repository;

  SearchPresenter(
    this._repository,
  ) : super(ValueNotifier(SearchState()));

  @override
  void mapEvent(SearchEvent event) {
    if (event is SearchSongEvent) {
      _searchSong(event.artistName);
    } else if (event is PlaySongEvent) {
      state.value = state.value.copy(playedSong: event.track);
    } else if (event is StopSongPlayingEvent) {
      state.value = SearchState().copy(songs: state.value.songs);
    } else if (event is PauseSongPlayingEvent) {
      // just set the copy of current state to update the ui.
      state.value = state.value.copy();
    } else if (event is ResumeSongPlayingEvent) {
      // just set the copy of current state to update the ui.
      state.value = state.value.copy();
    } else if (event is OnMusicPlayerStateChangedEvent) {
      _onStateChanged(event.state);
    } else if (event is SkipToPreviousSongEvent) {
      _skipToPreviousSong(state.value.playedSong);
    } else if (event is SkipToNextSongEvent) {
      _skipToNextSong(state.value.playedSong);
    }
  }

  void _searchSong(String artistName) async {
    final response = await _repository.searchSongByArtistName(
      artist: artistName,
    );

    if (response is ValueResult) {
      state.value = state.value.copy(
        songs: response.asValue.value.results,
      );
    }
  }

  void _onStateChanged(OniMusicState musicState) {
    if (musicState == OniMusicState.completed) {
      state.value = SearchState().copy(songs: state.value.songs);
    } else {
      state.value = state.value.copy();
    }
  }

  void _skipToPreviousSong(Song? currentSong) {
    if (currentSong == null || isFirstSong) return;
    final songIndex = state.value.songs.indexOf(currentSong);
    final previousSong = state.value.songs[songIndex - 1];
    state.value = state.value.copy(playedSong: previousSong);
  }

  void _skipToNextSong(Song? currentSong) {
    if (currentSong == null || isLastSong) return;
    final songIndex = state.value.songs.indexOf(currentSong);
    final nextSong = state.value.songs[songIndex + 1];
    state.value = state.value.copy(playedSong: nextSong);
  }

  bool get isLastSong {
    final currentSong = state.value.playedSong;
    if (currentSong == null) return false;
    final songIndex = state.value.songs.indexOf(currentSong);
    final latestSongIndex = state.value.songs.length - 1;
    return songIndex == latestSongIndex;
  }

  bool get isFirstSong {
    final currentSong = state.value.playedSong;
    if (currentSong == null) return false;
    final songIndex = state.value.songs.indexOf(currentSong);
    const firstSongIndex = 0;
    return songIndex == firstSongIndex;
  }
}
