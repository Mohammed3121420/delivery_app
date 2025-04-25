class BillItem {
  final String billDate;
  final String billNo;
  final String billAmt; // تم استبدال billSrl بـ billAmt
  final String billType;

  BillItem({
    required this.billDate,
    required this.billNo,
    required this.billAmt, // تعديل هنا لاستخدام billAmt
    required this.billType,
  });

  // factory constructor لتحويل JSON إلى BillItem
  factory BillItem.fromJson(Map<String, dynamic> json) {
    return BillItem(
      billDate: json['BILL_DATE'] ?? '',
      billNo: json['BILL_NO'] ?? '',
      billAmt: json['BILL_AMT'] ?? '', // تعديل هنا لاستخدام BILL_AMT بدلاً من BILL_SRL
      billType: json['BILL_TYPE'] ?? '',
    );
  }

  // لتحويل BillItem إلى Map لتخزينه في SQLite
  Map<String, dynamic> toMap() {
    return {
      'BILL_DATE': billDate,
      'BILL_NO': billNo,
      'BILL_AMT': billAmt, // تعديل هنا لاستخدام billAmt بدلاً من billSrl
      'BILL_TYPE': billType,
    };
  }

  // لتحويل Map (من SQLite) إلى BillItem
  factory BillItem.fromMap(Map<String, dynamic> map) {
    return BillItem(
      billDate: map['BILL_DATE'] ?? '',
      billNo: map['BILL_NO'] ?? '',
      billAmt: map['BILL_AMT'] ?? '', // تعديل هنا لاستخدام BILL_AMT بدلاً من BILL_SRL
      billType: map['BILL_TYPE'] ?? '',
    );
  }
}
