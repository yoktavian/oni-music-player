import 'package:flutter/material.dart';
import 'package:oni_music_player/src/data/feature_search/repository/search_repository_impl.dart';
import 'package:oni_music_player/src/presentation/base/presenter/oni_presenter.dart';
import 'package:oni_music_player/src/presentation/base/style/color_pallete.dart';
import 'package:oni_music_player/src/presentation/feature_search/component/search_header_widget.dart';
import 'package:oni_music_player/src/presentation/feature_search/component/search_result_widget.dart';
import 'package:oni_music_player/src/presentation/feature_search/presenter/search_presenter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController controller;

  late OniPresenter presenter;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    presenter = SearchPresenter(SearchRepositoryImpl());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.bleachedCedar,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SearchHeaderWidget(
              'Hello',
              'Yuda',
              'Find your favorite song by Artist name.',
              searchPlaceholder: 'Type the artist name here ...',
              onKeywordChanged: (keyword) {},
              onKeywordSubmitted: (keyword) {
                presenter.emit(SearchSongEvent(keyword));
              },
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: ValueListenableBuilder(
                      valueListenable: presenter.state,
                      builder: (context, value, child) {
                        final state = value as SearchState;

                        return ListView.separated(
                          itemBuilder: (context, index) {
                            print(state.tracks.first.trackName);
                            final track = state.tracks[index];

                            return SearchResultWidget(
                              track.artistName,
                              track.trackName,
                              track.collectionName,
                              track.artworkUrl100,
                              (played) {
                                if (played) {
                                  presenter.emit(PlayTrackEvent(track));
                                } else {
                                  presenter.emit(StopPlayedTrackEvent());
                                }
                              },
                              playing: state.playedTrack?.trackId == track.trackId,
                              key: Key(track.trackId.toString()),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 8);
                          },
                          itemCount: state.tracks.length,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
