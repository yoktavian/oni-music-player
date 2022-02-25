import 'package:oni_music_player/src/data/feature_search/model/track_model.dart';
import 'package:oni_music_player/src/data/response/base/base_response.dart';
import 'package:oni_music_player/src/domain/feature_search/entity/track.dart';

class TrackResponse extends BaseResponse<List<Track>> {
  TrackResponse(int resultCount, List<Track> results)
      : super(
          resultCount,
          results,
        );

  factory TrackResponse.fromJson(Map<String, dynamic> json) {
    return TrackResponse(
      json['resultCount'],
      (json['results'] as List<TrackModel>).map(
        (value) {
          return TrackModel.fromJson(value as Map<String, dynamic>);
        },
      ).toList(),
    );
  }
}
