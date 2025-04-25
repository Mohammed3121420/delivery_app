import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../features/auth/data/models/bill_item.dart';

class ApiService {
  final String apiUrl =
      'http://mdev.yemensoft.net:8087/OnyxDeliveryService/Service.svc/GetDeliveryBillsItems';

  // دالة لجلب بيانات الفواتير من API
  Future<List<BillItem>> fetchBillItems() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'Value': {
            'P_DLVRY_NO': '1010',
            'P_LANG_NO': '2',
            'P_BILL_SRL': '',
            'P_PRCSSD_FLG': '',
          },
        }),
      );

      if (response.statusCode == 200) {
        // print('Response body: ${response.body}');

        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        return parseResponse(jsonResponse);
      } else {
        throw Exception('فشل في تحميل الفواتير');
      }
    } catch (error) {
      throw Exception('خطأ في الاتصال بالخادم: $error');
    }
  }

  List<BillItem> parseResponse(Map<String, dynamic> jsonResponse) {
    if (jsonResponse.containsKey('Data') &&
        jsonResponse['Data'].containsKey('DeliveryBills')) {
      List<dynamic> data = jsonResponse['Data']['DeliveryBills'];
      return data.map((item) => BillItem.fromJson(item)).toList();
    } else {
      throw Exception('البيانات غير موجودة أو المفتاح غير صحيح');
    }
  }
}
