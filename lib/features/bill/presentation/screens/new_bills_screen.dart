import 'package:flutter/material.dart';
import '../../../auth/data/models/bill_item.dart';

class NewBillsScreen extends StatelessWidget {
  final List<BillItem> newBills;

  const NewBillsScreen({Key? key, required this.newBills}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: newBills.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt, size: 60, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No orders yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'You don\'t have any orders in your history',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: newBills.length,
              itemBuilder: (context, index) {
                final bill = newBills[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 3,
                  child: ListTile(
                    title: Text('رقم الفاتورة: ${bill.billNo}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('تاريخ الفاتورة: ${bill.billDate}'),
                        Text('رقم السلسلة: ${bill.billAmt}'),
                        Text('نوع الفاتورة: New'), // تم تغيير billType إلى New
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}