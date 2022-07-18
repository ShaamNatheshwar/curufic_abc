import 'package:curufic_abc/models/sleepDBModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SleepDataBaseProvider {
  static const String TABLE_NAME = 'sleepDB';
  static const String COLUMN_ID = "id";
  static const String COLUMN_TIME = 'date';
  static const String COLUMN_SLEEP = 'sleep';
  static const String COLUMN_STATE = 'state';

  SleepDataBaseProvider._();
  static final SleepDataBaseProvider db = SleepDataBaseProvider._();

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
      join(dbPath, 'sleepDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print('CREATING sleepDB table');
        await database.execute("CREATE TABLE $TABLE_NAME ("
            "$COLUMN_ID INTEGER PRIMARY KEY,"
            "$COLUMN_TIME TEXT,"
            "$COLUMN_SLEEP REAL,"
            "$COLUMN_STATE INTEGER"
            ")");
      },
    );
  }

  Future<List> getGraphData() async {
    List dataList = [];
    final db = await database;
    var datas = await db.query(
      TABLE_NAME,
      columns: [COLUMN_SLEEP],
    );
    datas.forEach((element) {
      SleepDB sleepDB = SleepDB.fromMap(element);
      dataList.add(sleepDB.sleep);
    });
    return dataList;
  }

  Future<List<SleepDB>> getData() async {
    final db = await database;

    var datas = await db.query(
      TABLE_NAME,
      columns: [COLUMN_ID, COLUMN_TIME, COLUMN_SLEEP, COLUMN_STATE],
    );

    List<SleepDB> dataList = [];

    datas.forEach((element) {
      SleepDB sleepDB = SleepDB.fromMap(element);

      dataList.add(sleepDB);
    });

    return dataList.reversed.toList();
  }

  Future<SleepDB> insert(SleepDB sleepDB) async {
    final db = await database;
    sleepDB.id = await db.insert(TABLE_NAME, sleepDB.toMap());
    return sleepDB;
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
