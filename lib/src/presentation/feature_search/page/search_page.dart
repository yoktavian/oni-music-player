import 'package:flutter/material.dart';
import 'package:oni_music_player/src/data/base/organizer/oni_music_organizer_impl.dart';
import 'package:oni_music_player/src/data/feature_search/repository/search_repository_impl.dart';
import 'package:oni_music_player/src/domain/base/organizer/oni_music_organizer.dart';
import 'package:oni_music_player/src/domain/feature_search/repository/search_repository.dart';
import 'package:oni_music_player/src/presentation/base/presenter/oni_presenter.dart';
import 'package:oni_music_player/src/presentation/base/style/oni_color_token.dart';
import 'package:oni_music_player/src/presentation/feature_search/component/search_header_widget.dart';
import 'package:oni_music_player/src/presentation/feature_search/component/search_result_widget.dart';
import 'package:oni_music_player/src/presentation/feature_search/component/search_song_playing_controller_widget.dart';
import 'package:oni_music_player/src/presentation/feature_search/presenter/search_presenter.dart';

class SearchPage extends StatefulWidget {
  final SearchRepository repository;

  final OniMusicOrganizer musicOrganizer;

  SearchPage({
    Key? key,
    SearchRepository? repository,
    OniMusicOrganizer? musicOrganizer,
  })  : repository = repository ?? SearchRepositoryImpl(),
        musicOrganizer = musicOrganizer ?? OniMusicOrganizerImpl(),
        super(key: key);

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
    presenter = SearchPresenter(widget.repository);
    musicOrganizer = widget.musicOrganizer
      ..listenState(
        (state) {
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
      backgroundColor: OniColorToken.bleachedCedar,
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
                            final song = state.songs[index];
                            final playedSongId = state.playedSong?.trackId;
                            final selectedSong = song.trackId == playedSongId;

                            if (selectedSong && musicOrganizer.isStopped) {
                              musicOrganizer.play(song.previewUrl);
                            }

                            return SearchResultWidget(
                              song.artistName,
                              song.trackName,
                              song.collectionName,
                              song.artworkUrl100,
                              (play) {
                                if (play) {
                                  musicOrganizer.stop();
                                  presenter.emit(StopSongPlayingEvent());
                                  presenter.emit(PlaySongEvent(song));
                                  musicOrganizer.play(song.previewUrl);
                                } else {
                                  musicOrganizer.stop();
                                  presenter.emit(StopSongPlayingEvent());
                                }
                              },
                              playing: selectedSong && musicOrganizer.isPlaying,
                              key: ObjectKey(song.trackId),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 8);
                          },
                          itemCount: state.songs.length,
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
                final isPlaying = musicOrganizer.isPlaying;
                final isPaused = musicOrganizer.isPaused;
                final showControlMenu = isPlaying || isPaused;

                if (!showControlMenu) {
                  return const SizedBox.shrink();
                }

                final state = value as SearchState;
                final searchPresenter = presenter as SearchPresenter;
                final songName = state.playedSong?.trackName ?? '';
                final artistName = state.playedSong?.artistName ?? '';
                var playingStatusText = ' - is playing ..';
                if (musicOrganizer.isPaused) {
                  playingStatusText = ' - is paused ..';
                }

                return SongPlayingControllerWidget(
                  songName: songName,
                  artistName: artistName,
                  playingStatusText: playingStatusText,
                  firstSong: searchPresenter.isFirstSong,
                  lastSong: searchPresenter.isLastSong,
                  paused: musicOrganizer.isPaused,
                  played: musicOrganizer.isPlaying,
                  onPause: () {
                    musicOrganizer.pause();
                    presenter.emit(PauseSongPlayingEvent());
                  },
                  onResume: () {
                    musicOrganizer.resume();
                    presenter.emit(ResumeSongPlayingEvent());
                  },
                  onSkipToPrevious: () {
                    musicOrganizer.stop();
                    presenter.emit(SkipToPreviousSongEvent());
                  },
                  onSkipToNext: () {
                    musicOrganizer.stop();
                    presenter.emit(SkipToNextSongEvent());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
