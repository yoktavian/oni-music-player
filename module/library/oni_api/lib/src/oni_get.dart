import 'package:async/async.dart';

abstract class OniGet {
  Future<Result<dynamic>> get({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });
}
