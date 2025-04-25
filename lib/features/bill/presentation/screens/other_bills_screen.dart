import 'package:flutter/material.dart';
import '../../../auth/data/models/bill_item.dart';

class OtherBillsScreen extends StatelessWidget {
  final List<BillItem> otherBills;

  const OtherBillsScreen({super.key, required this.otherBills});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // محتوى الشاشة
          Expanded(
            child:
                otherBills.isEmpty
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
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: otherBills.length,
                      itemBuilder: (context, index) {
                        final bill = otherBills[index];
                        final status = _getStatus(bill.billType);
                        final amount = bill.billAmt.split('.').first;
                        return Container(
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '#${bill.billNo}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Status'),
                                    Text(
                                      status,
                                      style: TextStyle(
                                        color: _getStatusColor(status),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total price'),
                                    Text('$amount LE'),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [Text('Date'), Text(bill.billDate)],
                                ),
                                SizedBox(height: 12),
                                Divider(height: 1),
                                SizedBox(height: 8),
                                Center(
                                  child: Text(
                                    'Order Details',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

  String _getStatus(String? billType) {
    switch (billType) {
      case '1':
        return 'Delivering';
      case '2':
        return 'Delivered';
      case '3':
        return 'Returned';
      default:
        return 'Unknown';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivering':
        return Colors.orange;
      case 'Delivered':
        return Colors.green;
      case 'Returned':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
