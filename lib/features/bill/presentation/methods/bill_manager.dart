import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/database_helper.dart';
import '../../../auth/data/models/bill_item.dart';

class BillManager {
  final ApiService apiService = ApiService();
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<void> fetchAndSaveBills() async {
    try {
      List<BillItem> billItems = await apiService.fetchBillItems();

      for (BillItem billItem in billItems) {
        await dbHelper.insertBillItem(billItem);
      }

    } catch (error) {
      // ignore: avoid_print
      print('خطأ في جلب البيانات وحفظها: $error');
    }
  }

  Future<List<BillItem>> getBillsFromDatabase() async {
    return await dbHelper.fetchBills();
  }
}
