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
  static const headerImage =
      'https://images.unsplash.com/photo-1571330735066-03aaa9429d89?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2670&q=80';

  late TextEditingController controller;

  late OniPresenter presenter;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    presenter = SearchPresenter(SearchRepositoryImpl());
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
              headerImage,
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
                            print(state.tracks?.first.trackName);
                            final track = state.tracks?[index];

                            return SearchResultWidget(
                              track?.artistName ?? '',
                              track?.trackName ?? '',
                              track?.collectionName ?? '',
                              track?.artworkUrl100 ?? '',
                                  (played) {
                                print(played);
                              },
                              playing: index == 0,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 8);
                          },
                          itemCount: state.tracks?.length ?? 0,
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
