import 'package:flutter/material.dart';
import 'package:oni_music_player/src/data/base/organizer/oni_music_organizer_impl.dart';
import 'package:oni_music_player/src/data/feature_search/repository/search_repository_impl.dart';
import 'package:oni_music_player/src/domain/base/organizer/oni_music_organizer.dart';
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

  late OniMusicOrganizer musicOrganizer;

  @override
  void initState() {
    super.initState();
    presenter = SearchPresenter(SearchRepositoryImpl());
    musicOrganizer = OniMusicOrganizerImpl(
      onStateChanged: (state) {
        presenter.emit(OnMusicPlayerStateChangedEvent(state));
      },
    );
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    presenter.dispose();
    musicOrganizer.disposed();
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
                            final track = state.tracks[index];
                            final selectedSong = track.trackId == state.playedSong?.trackId;

                            if (selectedSong && musicOrganizer.isStopped) {
                              musicOrganizer.play(track.previewUrl);
                            }

                            return SearchResultWidget(
                              track.artistName,
                              track.trackName,
                              track.collectionName,
                              track.artworkUrl100,
                              (play) {
                                if (play) {
                                  musicOrganizer.stop();
                                  presenter.emit(StopSongPlayingEvent());
                                  presenter.emit(PlaySongEvent(track));
                                  musicOrganizer.play(track.previewUrl);
                                } else {
                                  musicOrganizer.stop();
                                  presenter.emit(StopSongPlayingEvent());
                                }
                              },
                              playing: selectedSong && musicOrganizer.isPlaying,
                              key: ObjectKey(track.trackId),
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
            ValueListenableBuilder(
              valueListenable: presenter.state,
              builder: (context, value, widget) {
                final showControlMenu = musicOrganizer.isPlaying || musicOrganizer.isPaused;
                if (!showControlMenu) return const SizedBox.shrink();

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    color: Colors.white30,
                  ),
                  child: Row(
                    children: [
                      if (musicOrganizer.isPlaying)
                        InkWell(
                          onTap: () {
                            musicOrganizer.pause();
                            presenter.emit(PauseSongPlayingEvent());
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white30,
                          ),
                        )
                      else
                        InkWell(
                          onTap: () {
                            musicOrganizer.resume();
                            presenter.emit(ResumeSongPlayingEvent());
                          },
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white30,
                          ),
                        )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
