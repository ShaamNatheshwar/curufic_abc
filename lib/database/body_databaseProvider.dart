import 'package:curufic_abc/models/bodyModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BodyDataBaseProvider {
  static const String TABLE_NAME = 'bloodpressureDB';
  static const String COLUMN_ID = "id";
  static const String COLUMN_TIME = 'date';
  static const String COLUMN_BMI = 'bmi';
  static const String COLUMN_BF = 'bf';
  static const String COLUMN_WEIGHT = 'weight';
  static const String COLUMN_GENDER = 'gender';

  BodyDataBaseProvider._();
  static final BodyDataBaseProvider db = BodyDataBaseProvider._();

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
      join(dbPath, 'bmiDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print('CREATING bodyDB table');
        await database.execute("CREATE TABLE $TABLE_NAME ("
            "$COLUMN_ID INTEGER PRIMARY KEY,"
            "$COLUMN_TIME TEXT,"
            "$COLUMN_BMI REAL,"
            "$COLUMN_BF REAL,"
            "$COLUMN_WEIGHT REAL,"
            "$COLUMN_GENDER INTEGER"
            ")");
      },
    );
  }

  Future checkFirstLogin() async {
    final db = await database;
    var datas = await db.query(TABLE_NAME, columns: [COLUMN_ID]);
    return datas;
  }

  Future<List> getGraphData() async {
    List bmiDataList = [];
    final db = await database;
    var datas = await db.query(TABLE_NAME, columns: [COLUMN_BMI]);
    datas.forEach((element) {
      BodyDB bmiDB = BodyDB.fromMap(element);
      bmiDataList.add(bmiDB.bmi);
    });
    return bmiDataList;
  }

  Future<List<BodyDB>> getData() async {
    final db = await database;

    var datas = await db.query(
      TABLE_NAME,
      columns: [
        COLUMN_ID,
        COLUMN_TIME,
        COLUMN_BMI,
        COLUMN_BF,
        COLUMN_WEIGHT,
        COLUMN_GENDER
      ],
    );

    List<BodyDB> dataList = [];

    datas.forEach((element) {
      BodyDB bmiDB = BodyDB.fromMap(element);

      dataList.add(bmiDB);
    });

    return dataList.reversed.toList();
  }

  Future<BodyDB> insert(BodyDB bmiDB) async {
    final db = await database;
    bmiDB.id = await db.insert(TABLE_NAME, bmiDB.toMap());
    return bmiDB;
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
