import 'package:dio/dio.dart';

class SignupRepository {
  SignupRepository({this.client});

  final Dio client;

  Future<void> signUpUser({
    String name,
    String email,
    String password,
    String adress,
    String mobile,
    String district,
    String state,
    String city,
  }) async {
    try {
      var url =
          'salvar-cliente?name=$name&email=$email&password=$password&password_confirmation=$password&address=$adress&mobile=$mobile&mobile=$mobile&state=$state&city=$city';
      await client.post(
        url,
        options: Options(
          method: 'POST',
          responseType: ResponseType.plain,
        ),
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
