import 'package:flutter/material.dart';
import 'package:oni_music_player/src/presentation/feature_search/component/search_track_playing_indicator_widget.dart';

class MusicVisualizerWidget extends StatelessWidget {
  final List<Color> colors;
  final List<int> durations;

  const MusicVisualizerWidget(this.colors, this.durations, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        colors.length,
        (index) => TrackPlayingIndicatorWidget(
          colors[index],
          Duration(
            milliseconds: durations[index],
          ),
        ),
      ),
    );
  }
}
