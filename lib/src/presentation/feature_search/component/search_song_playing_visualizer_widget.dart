import 'package:flutter/material.dart';
import 'package:oni_music_player/src/presentation/feature_search/component/search_song_playing_indicator_widget.dart';

class SongPlayingVisualizerWidget extends StatelessWidget {
  final List<Color> colors;
  final List<int> durations;

  const SongPlayingVisualizerWidget(this.colors, this.durations, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        colors.length,
        (index) => SongPlayingIndicatorWidget(
          colors[index],
          Duration(
            milliseconds: durations[index],
          ),
        ),
      ),
    );
  }
}
