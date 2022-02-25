import 'package:async/async.dart';

abstract class SearchRepository {
  Future<Result> searchSongByArtistName({required String artist});
}
