import 'package:flutter/material.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/database_helper.dart';
import '../../../../core/utils/shared_preferences_helper.dart';
import '../../../auth/data/models/bill_item.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../../../bill/presentation/screens/new_bills_screen.dart';
import '../../../bill/presentation/screens/other_bills_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ApiService apiService = ApiService();
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  late TabController _tabController;

  List<BillItem> newBills = [];
  List<BillItem> otherBills = [];
  String userName = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchAndSaveBills();
    loadUserName();
  }

  void loadUserName() async {
    final helper = SharedPreferencesHelper();
    final name = await helper.getUserName();
    setState(() {
      userName = name ?? 'User'; // قيمة افتراضية إذا كان الاسم فارغًا أو null
    });
  }

  Future<void> fetchAndSaveBills() async {
    final billItems = await apiService.fetchBillItems();
    for (var bill in billItems) {
      await dbHelper.insertBillItem(bill); // حفظ في SQLite
    }
    await loadBillsFromDB(); // تحميل من SQLite
  }

  Future<void> loadBillsFromDB() async {
    final newBillsFromDB = await dbHelper.fetchBillsByBillType("0");
    final otherBillsFromDB = await dbHelper.fetchBillsByBillType("1");

    setState(() {
      newBills = newBillsFromDB;
      otherBills = otherBillsFromDB;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        bottom: TabBar(
          controller: _tabController,
          tabs: [Tab(text: 'New'), Tab(text: 'Others')],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          NewBillsScreen(newBills: newBills),
          OtherBillsScreen(otherBills: otherBills),
        ],
      ),
    );
  }
}
