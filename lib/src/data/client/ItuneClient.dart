import 'package:oni_api/oni_api.dart';

class ItuneClient extends OniApi {
  static const ituneBaseURL = 'https://itunes.apple.com';

  ItuneClient() : super(baseUrl: ituneBaseURL);
}