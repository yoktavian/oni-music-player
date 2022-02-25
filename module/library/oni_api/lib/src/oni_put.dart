import 'package:async/async.dart';

abstract class OniPut {
  Future<Result<dynamic>> put({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });
}
