import 'dart:convert';

import 'package:oni_api/oni_api.dart';
import 'package:oni_music_player/src/data/client/ItuneClient.dart';
import 'package:oni_music_player/src/domain/feature_search/repository/search_repository.dart';
import 'package:async/async.dart';

class SearchRepositoryImpl extends SearchRepository {
  final OniGet client;

  SearchRepositoryImpl({OniGet? client}) : client = client ?? ItuneClient();
  
  @override
  Future searchSongByArtistName({required String artist}) async {
    final response = await client.get(
      path: '/search',
      queryParameters: {
        'term': artist,
        'entity': 'song',
      },
    );

    if (response is ValueResult) {
      final jsonResponse = jsonDecode(response.asValue.value);
    }

    return response;
  }
}
