import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oni_music_player/src/presentation/base/ui/color_pallete.dart';

class SearchResultWidget extends StatelessWidget {
  final String songName;

  final String artistName;

  final String album;

  final String albumImageUrl;

  final bool playing;

  const SearchResultWidget(
    this.songName,
    this.artistName,
    this.album,
    this.albumImageUrl, {
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  artistName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  album,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.amberAccent,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
