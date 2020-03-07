import 'package:dio/dio.dart';

import 'API.dart';

class DioBuilder {
  static Dio getDio() {
    return Dio()
      ..options.baseUrl = BASE_API
      ..options.headers = <String, dynamic>{'Content-Type': 'application/json'};
  }
}
