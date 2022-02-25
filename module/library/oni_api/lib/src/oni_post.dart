import 'package:async/async.dart';

abstract class OniPost {
  Future<Result<dynamic>> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });
}
