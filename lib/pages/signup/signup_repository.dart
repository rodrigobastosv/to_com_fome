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
    https: //tanamaodelivery.com.br/api/salvar-cliente
    // ?name=valdson barbosa de oliveira
    // &email=valdsondeoliveira1@hotmail.com&
    // password=12345678&
    // mobile=31991365085&
    // address=rua test
    // e&district=canaa
    // &district=Ipatinga
    // &state=MG
    // &password_confirmation=12345678
    try {
      final a = await client.post(
        'salvar-cliente?name=$name&email=$email&password=$password&password_confirmation=$password&address=$adress&mobile=$mobile'
        '&mobile=$mobile&state=$state&city=$city',
        options: Options(
          method: 'POST',
          responseType: ResponseType.plain,
        ),
      );
      print(a);
      print(a.data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
