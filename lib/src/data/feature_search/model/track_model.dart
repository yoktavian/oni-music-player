import 'package:oni_music_player/src/domain/feature_search/entity/track.dart';

class TrackModel extends Track {
  TrackModel(
    int artistId,
    String artistName,
    String trackName,
    String collectionName,
    String artworkUrl60,
    String artworkUrl100,
    String previewUrl,
  ) : super(
    artistId,
    artistName,
    trackName,
    collectionName,
    artworkUrl60,
    artworkUrl100,
    previewUrl,
  );

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      json['artistId'] as int,
      json['artistName'] as String,
      json['trackName'] as String,
      json['collectionName'] as String,
      json['artworkUrl60'] as String,
      json['artworkUrl100'] as String,
      json['previewUrl'] as String,
    );
  }
}
