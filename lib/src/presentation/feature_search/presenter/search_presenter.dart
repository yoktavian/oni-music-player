import 'package:flutter/widgets.dart';
import 'package:oni_music_player/src/domain/feature_search/entity/track.dart';
import 'package:oni_music_player/src/domain/feature_search/repository/search_repository.dart';
import 'package:oni_music_player/src/presentation/base/presenter/oni_presenter.dart';
import 'package:async/async.dart';

class SearchState {
  List<Track> tracks;

  Track? playedTrack;

  SearchState({this.tracks = const [], this.playedTrack});

  SearchState copyWith({List<Track>? tracks, Track? playedTrack}) {
    return SearchState(
      tracks: tracks ?? this.tracks,
      playedTrack: playedTrack ?? this.playedTrack,
    );
  }
}

abstract class SearchEvent {}

class SearchSongEvent extends SearchEvent {
  final String artistName;

  SearchSongEvent(this.artistName);
}

class PlayTrackEvent extends SearchEvent {
  final Track track;

  PlayTrackEvent(this.track);
}

class StopPlayedTrackEvent extends SearchEvent {
  StopPlayedTrackEvent();
}

class SearchPresenter extends OniPresenter<SearchState, SearchEvent> {
  final SearchRepository repository;

  SearchPresenter(this.repository) : super(ValueNotifier(SearchState()));

  @override
  void mapEvent(SearchEvent event) {
    if (event is SearchSongEvent) {
      _searchSong(event.artistName);
    } else if (event is PlayTrackEvent) {
      _playTrack(event.track);
    } else if (event is StopPlayedTrackEvent) {
      _stopTrack();
    }
  }

  void _searchSong(String artistName) async {
    final response = await repository.searchSongByArtistName(
      artist: artistName,
    );

    if (response is ValueResult) {
      state.value = state.value.copyWith(
        tracks: response.asValue.value.results,
      );
    }
  }

  void _playTrack(Track track) {
    state.value = state.value.copyWith(playedTrack: track);
  }

  void _stopTrack() {
    state.value = SearchState().copyWith(tracks: state.value.tracks);
  }
}
