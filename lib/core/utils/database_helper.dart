import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../features/auth/data/models/bill_item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bills.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 4,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 4) {
      await db.execute('DROP TABLE IF EXISTS bills;');

      await _createDB(db, newVersion);
    }
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS bills (
      BILL_DATE TEXT,
      BILL_NO TEXT PRIMARY KEY,
      BILL_AMT TEXT, 
      BILL_TYPE TEXT
    )''');
  }

  Future<void> insertBillItem(BillItem bill) async {
    final db = await instance.database;
    await db.insert(
      'bills',
      bill.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<BillItem>> fetchBills() async {
    final db = await instance.database;
    final result = await db.query('bills');
    return result.map((map) => BillItem.fromMap(map)).toList();
  }

  Future<List<BillItem>> fetchBillsByBillType(String type) async {
    final db = await instance.database;
    final result = await db.query(
      'bills',
      where: 'BILL_TYPE = ?',
      whereArgs: [type],
    );
    return result.map((json) => BillItem.fromMap(json)).toList();
  }
}
