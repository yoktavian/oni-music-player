import 'package:oni_music_player/src/domain/feature_search/entity/song.dart';

class SongModel extends Song {
  SongModel(
    int artistId,
    String artistName,
    int trackId,
    String trackName,
    String collectionName,
    String artworkUrl60,
    String artworkUrl100,
    String previewUrl,
  ) : super(
    artistId,
    artistName,
    trackId,
    trackName,
    collectionName,
    artworkUrl60,
    artworkUrl100,
    previewUrl,
  );

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      json['artistId'] as int,
      json['artistName'] as String,
      json['trackId'] as int,
      json['trackName'] as String,
      json['collectionName'] as String,
      json['artworkUrl60'] as String,
      json['artworkUrl100'] as String,
      json['previewUrl'] as String,
    );
  }
}
