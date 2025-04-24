import 'package:http/http.dart' as http;
import 'dart:convert';
import '../user_model.dart';

class AuthRemoteDataSource {
  final http.Client client;
  AuthRemoteDataSource(this.client);

  Future<UserModel?> login({
    required String userId,
    required String password,
  }) async {
    final url = Uri.parse('https://your-api-url.com/CheckDeliveryLogin');

    final response = await client.post(
      url,
      body: {
        'delivery_no': userId,
        'password': password,
        'language_no': '2',
      },
    );

    final data = json.decode(response.body);
    if (response.statusCode == 200 && data['success'] == true) {
      return UserModel(userId: userId, token: data['token']);
    }

    return null;
  }
}
