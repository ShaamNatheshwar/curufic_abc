import 'package:curufic_abc/models/bpDBModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BpDataBaseProvider {
  static const String TABLE_NAME = 'bloodpressureDB';
  static const String COLUMN_ID = "id";
  static const String COLUMN_TIME = 'date';
  static const String COLUMN_SBP = 'sbp';
  static const String COLUMN_DBP = 'dbp';
  static const String COLUMN_HR = 'hr';
  static const String COLUMN_STATE = 'state';

  BpDataBaseProvider._();
  static final BpDataBaseProvider db = BpDataBaseProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'bloodpressureDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print('CREATING bloodpressureDB table');
        await database.execute("CREATE TABLE $TABLE_NAME ("
            "$COLUMN_ID INTEGER PRIMARY KEY,"
            "$COLUMN_TIME TEXT,"
            "$COLUMN_SBP INTEGER,"
            "$COLUMN_DBP INTEGER,"
            "$COLUMN_HR INTEGER,"
            "$COLUMN_STATE INTEGER"
            ")");
      },
    );
  }

  Future<List> getGraphData() async {
    List sbpDataList = [];
    List dbpDataList = [];
    final db = await database;
    var datas = await db.query(TABLE_NAME, columns: [COLUMN_SBP, COLUMN_DBP]);
    datas.forEach((element) {
      BloodPressureDB bloodPressureDB = BloodPressureDB.fromMap(element);
      sbpDataList.add(bloodPressureDB.sbp);
      dbpDataList.add(bloodPressureDB.dbp);
    });
    return [sbpDataList, dbpDataList];
  }

  Future<List<BloodPressureDB>> getData() async {
    final db = await database;

    var datas = await db.query(
      TABLE_NAME,
      columns: [
        COLUMN_ID,
        COLUMN_TIME,
        COLUMN_SBP,
        COLUMN_DBP,
        COLUMN_HR,
        COLUMN_STATE
      ],
    );

    List<BloodPressureDB> dataList = [];

    datas.forEach((element) {
      BloodPressureDB bloodPressureDB = BloodPressureDB.fromMap(element);

      dataList.add(bloodPressureDB);
    });

    return dataList.reversed.toList();
  }

  Future<BloodPressureDB> insert(BloodPressureDB bloodPressureDB) async {
    final db = await database;
    bloodPressureDB.id = await db.insert(TABLE_NAME, bloodPressureDB.toMap());
    return bloodPressureDB;
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(
      TABLE_NAME,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
