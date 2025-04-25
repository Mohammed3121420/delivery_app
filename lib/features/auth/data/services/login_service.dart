// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  final url = Uri.parse(
    "http://mdev.yemensoft.net:8087/OnyxDeliveryService/Service.svc/CheckDeliveryLogin",
  );

  Future<Map<String, dynamic>> login(String userId, String password, String lang) async {
    try {
      final Map<String, dynamic> data = {
        "Value": {
          "P_LANG_NO": lang,
          "P_DLVRY_NO": userId,
          "P_PSSWRD": password,
        },
      };

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("Response data: $responseData");

        if (responseData != null && responseData['Result'] != null) {
          final result = responseData['Result'];
          final errNo = result['ErrNo'];
          final errMsg = result['ErrMsg'];

          if (errNo == 0) {
            final deliveryName = responseData['Data']?['DeliveryName'] ?? '';
            print("Login successful!");
            return {"success": true, "name": deliveryName};
          } else {
            print("Login failed: $errMsg");
            return {"success": false, "message": errMsg};
          }
        } else {
          print("Unexpected response format: $responseData");
          return {"success": false, "message": "Unexpected response"};
        }
      } else {
        print("HTTP request failed with status: ${response.statusCode}");
        return {"success": false, "message": "HTTP error"};
      }
    } catch (error) {
      print("Error during login: $error");
      return {"success": false, "message": error.toString()};
    }
  }
}
