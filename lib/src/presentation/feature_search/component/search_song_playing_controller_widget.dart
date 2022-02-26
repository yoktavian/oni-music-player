import 'package:flutter/material.dart';

class SongPlayingControllerWidget extends StatelessWidget {
  final String songName;

  final String artistName;

  final String playingStatusText;

  final bool paused;

  final bool played;

  final VoidCallback onPause;

  final VoidCallback onResume;

  const SongPlayingControllerWidget({
    Key? key,
    required this.songName,
    required this.artistName,
    required this.playingStatusText,
    required this.paused,
    required this.played,
    required this.onPause,
    required this.onResume,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        gradient: LinearGradient(
          colors: [
            Colors.white12,
            Colors.white30,
            Colors.white38,
          ],
        ),
      ),
      child: Row(
        children: [
          if (played)
            InkWell(
              onTap: onPause,
              child: const Icon(
                Icons.pause_circle,
                color: Colors.redAccent,
              ),
            )
          else
            InkWell(
              onTap: onResume,
              child: const Icon(
                Icons.play_arrow,
                color: Colors.tealAccent,
              ),
            ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: songName,
                        style: const TextStyle(color: Colors.white60),
                      ),
                      TextSpan(
                        text: playingStatusText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  artistName,
                  style: const TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 10,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
