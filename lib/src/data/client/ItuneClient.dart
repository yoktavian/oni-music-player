import 'package:oni_api/oni_api.dart';

/// Client for any API that depends on itunes.
/// Need to create another client if we have to depends
/// on the another base URL.
class ItuneClient extends OniApi {
  static const ituneBaseURL = 'https://itunes.apple.com';

  ItuneClient() : super(baseUrl: ituneBaseURL);
}
