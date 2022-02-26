import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:oni_api/oni_api.dart';
import 'package:async/async.dart';
import 'package:oni_music_player/src/data/client/ItuneClient.dart';
import 'package:oni_music_player/src/data/feature_search/response/song_response.dart';
import 'package:oni_music_player/src/domain/feature_search/repository/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  final OniGet client;

  SearchRepositoryImpl({OniGet? client}) : client = client ?? ItuneClient();

  @override
  Future<Result> searchSongByArtistName({required String artist}) async {
    final response = await client.get(
      path: '/search',
      queryParameters: {
        'term': artist,
        'entity': 'song',
      },
    );

    if (response is ValueResult) {
      final json = jsonDecode(response.asValue.value);
      final trackResponse = await compute(_parseTrackResponse, json);
      return Result.value(trackResponse);
    }

    return response;
  }
}

SongResponse _parseTrackResponse(json) {
  return SongResponse.fromJson(json);
}