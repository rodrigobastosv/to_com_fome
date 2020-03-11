import 'package:dio/dio.dart';

class SignupRepository {
  SignupRepository({this.client});

  final Dio client;

  Future<void> signUpUser({
    String name,
    String email,
    String password,
    String adress,
  }) async {
    https: //tanamaodelivery.com.br/api/salvar-cliente
    // ?name=valdson barbosa de oliveira
    // &email=valdsondeoliveira1@hotmail.com&
    // password=12345678&
    // mobile=31991365085&
    // address=rua test
    // e&district=canaa
    // &city=Ipatinga
    // &state=MG
    // &password_confirmation=12345678
    try {
      await client.post(
        'salvar-cliente?name=$name&email=$email&address=$adress',
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
