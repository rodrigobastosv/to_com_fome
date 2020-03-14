import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:to_com_fome/model/user_model.dart';

class SigninRepository {
  SigninRepository(this.client);

  final Dio client;

  Future<UserModel> signInUser(String email, String password) async {
    final response = await client.post(
      'login-api/?email=$email&password=$password',
      options: Options(
        method: 'POST',
        responseType: ResponseType.plain,
      ),
    );
    final decoded = jsonDecode(response.data);
    return UserModel.fromJson(decoded);
  }
}
