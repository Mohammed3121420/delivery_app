import 'package:flutter/material.dart';
import '../../../auth/data/models/bill_item.dart';

class NewBillsScreen extends StatelessWidget {
  final List<BillItem> newBills;

  const NewBillsScreen({super.key, required this.newBills});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          newBills.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.assignment,
                        size: 60,
                        color: Colors.pinkAccent,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'No orders yet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'You don\'t have any orders in your history',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: newBills.length,
                itemBuilder: (context, index) {
                  final bill = newBills[index];
                  final status = _getStatus(bill.billType);
                  final amount = bill.billAmt.split('.').first;
                  final statusColor = _getStatusColor(status);
                  final buttonColor = _getButtonColor(status);

                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
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
                                        color: statusColor,
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
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 60,
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Center(
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                'Order Details',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
  String _getStatus(String? billType) {
    switch (billType) {
      case '0':
        return 'New';
      default:
        return 'Unknown';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'New':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getButtonColor(String status) {
    switch (status) {
      case 'New':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }
}
