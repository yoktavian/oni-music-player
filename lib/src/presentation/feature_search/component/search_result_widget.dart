import 'package:flutter/material.dart';
import 'package:oni_music_player/src/presentation/base/style/color_pallete.dart';
import 'package:oni_music_player/src/presentation/feature_search/component/search_track_playing_visualizer_widget.dart';

class SearchResultWidget extends StatelessWidget {
  final String songName;

  final String artistName;

  final String album;

  final String albumImageUrl;

  final bool playing;

  final ValueChanged<bool> onPlayStatusChanged;

  const SearchResultWidget(
    this.songName,
    this.artistName,
    this.album,
    this.albumImageUrl,
    this.onPlayStatusChanged, {
    Key? key,
    this.playing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        gradient: LinearGradient(
          colors: [
            ColorPalette.mineShaft,
            ColorPalette.mineShaft,
            ColorPalette.bleachedCedar,
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  albumImageUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  songName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  artistName,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  album,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.amberAccent,
                  ),
                ),
              ],
            ),
          ),
          if (playing)
            const Expanded(
              child: MusicVisualizerWidget(
                [
                  Colors.greenAccent,
                  Colors.yellow,
                  Colors.teal,
                  Colors.redAccent,
                ],
                [1000, 1800, 2000, 900],
              ),
            ),
          AnimatedPlayIcon(onPlayStatusChanged),
        ],
      ),
    );
  }
}

class AnimatedPlayIcon extends StatefulWidget {
  final ValueChanged<bool> onPlayStatusChanged;

  const AnimatedPlayIcon(this.onPlayStatusChanged, {Key? key}) : super(key: key);

  @override
  State<AnimatedPlayIcon> createState() => _AnimatedPlayIconState();
}

class _AnimatedPlayIconState extends State<AnimatedPlayIcon>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    )..addListener(_animationListener);
  }

  void _animationListener() {
    setState(() {});
  }

  @override
  void dispose() {
    animation.removeListener(_animationListener);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final isPlayed = !animation.isCompleted;
        widget.onPlayStatusChanged(isPlayed);

        if (animation.isCompleted) {
          animationController.reverse();
        } else {
          animationController.forward();
        }
      },
      child: AnimatedIcon(
        icon: AnimatedIcons.play_pause,
        progress: animation,
        size: 40,
        color: Colors.redAccent,
      ),
    );
  }
}
