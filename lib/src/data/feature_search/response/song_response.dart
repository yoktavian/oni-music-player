import 'package:oni_music_player/src/data/feature_search/model/song_model.dart';
import 'package:oni_music_player/src/data/base/response/base_response.dart';
import 'package:oni_music_player/src/domain/feature_search/entity/song.dart';

class SongResponse extends BaseResponse<List<Song>> {
  SongResponse(int resultCount, List<Song> results)
      : super(
          resultCount,
          results,
        );

  factory SongResponse.fromJson(Map<String, dynamic> json) {
    return SongResponse(
      json['resultCount'],
      (json['results'] as List<dynamic>).map(
        (value) {
          return SongModel.fromJson(value as Map<String, dynamic>);
        },
      ).toList(),
    );
  }
}
