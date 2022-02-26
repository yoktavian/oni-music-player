import 'package:flutter/material.dart';
import 'package:oni_music_player/src/presentation/base/style/oni_color_token.dart';
import 'package:oni_music_player/src/presentation/feature_search/component/search_song_playing_visualizer_widget.dart';

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
            OniColorToken.mineShaft,
            OniColorToken.mineShaft,
            OniColorToken.bleachedCedar,
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  artistName,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Text(
                  album,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.amberAccent,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (playing) ...[
                  const SongPlayingVisualizerWidget(
                    [
                      Colors.greenAccent,
                      Colors.yellow,
                      Colors.teal,
                      Colors.redAccent,
                    ],
                    [1000, 1800, 2000, 900],
                  ),
                  InkWell(
                    onTap: () => onPlayStatusChanged(false),
                    child: const Icon(
                      Icons.stop,
                      size: 24,
                      color: Colors.redAccent,
                    ),
                  ),
                ] else
                  InkWell(
                    onTap: () => onPlayStatusChanged(true),
                    child: const Icon(
                      Icons.play_arrow,
                      size: 24,
                      color: Colors.tealAccent,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
