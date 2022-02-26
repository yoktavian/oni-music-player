import 'package:async/src/result/result.dart';
import 'package:oni_music_player/src/domain/feature_search/repository/search_repository.dart';

class FakeSearchRepository extends SearchRepository {
  final Result result;

  FakeSearchRepository(this.result);

  @override
  Future<Result> searchSongByArtistName({required String artist}) async {
    return result;
  }

  factory FakeSearchRepository.success(Result result) {
    return FakeSearchRepository(result);
  }

  factory FakeSearchRepository.error(Exception error) {
    return FakeSearchRepository(Result.error(error));
  }
}
