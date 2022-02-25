import 'package:flutter/widgets.dart';
import 'package:oni_music_player/src/domain/feature_search/entity/track.dart';
import 'package:oni_music_player/src/domain/feature_search/repository/search_repository.dart';
import 'package:oni_music_player/src/presentation/base/presenter/oni_presenter.dart';
import 'package:async/async.dart';

class SearchState {
  List<Track>? tracks;

  SearchState({this.tracks});

  SearchState copyWith({List<Track>? tracks}) {
    return SearchState(tracks: tracks ?? this.tracks);
  }
}

abstract class SearchEvent {}

class SearchSongEvent extends SearchEvent {
  final String artistName;

  SearchSongEvent(this.artistName);
}

class SearchPresenter extends OniPresenter<SearchState, SearchEvent> {
  final SearchRepository repository;

  SearchPresenter(this.repository) : super(ValueNotifier(SearchState()));

  @override
  void mapEvent(SearchEvent event) {
    if (event is SearchSongEvent) {
      _searchSong(event.artistName);
    }
  }

  void _searchSong(String artistName) async {
    final response = await repository.searchSongByArtistName(
      artist: artistName,
    );

    if (response is ValueResult) {
      state.value = state.value.copyWith(tracks: response.asValue.value.results);
    }
  }
}
