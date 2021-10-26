import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stok_takip_offline/database/database_model.dart';

class DatabaseHelper {
  Database? _database;

  final String _notesTable = "stock";
  final String _columnID = "id";
  final String _columnStockName = "stockName";
  final String _columnStockCode = "stockCode";
  final String _columnUnit = "unit";
  final String _columnPurchasePrice = "purchasePrice";
  final String _columnSalePrice = "salePrice";
  final String _columnExplanation = "explanation";
  final String _updateDate = "updateDate";
  final String _stockIn = "stockIn";
  final String _stockOut = "stockOut";

  Future<Database?> get database async {
    _database == null
        ? _database = await initializeDatabase()
        : print("Db is not empty");
    print("i working");
    return _database;
  }

  Future<Database> initializeDatabase() async {
    String dbPath = join(await getDatabasesPath(), "StokTakip.db");
    var stockDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return stockDb;
  }

  void createDb(Database db, int version) async {
    await db.execute('''
        Create table $_notesTable
        (
        $_columnID integer primary key, $_columnStockName text, 
        $_columnStockCode text, $_columnUnit integer, 
        $_columnPurchasePrice double, $_columnSalePrice double,
        $_columnExplanation text, $_updateDate DATETIME DEFAULT CURRENT_DATE,
        $_stockIn integer, $_stockOut integer
        )        
        ''');

    await db.execute('''      
        CREATE TRIGGER updateDate AFTER UPDATE
        ON $_notesTable
        BEGIN
          update stock set updateDate = Date('now') where id = old.id;
        END
        ''');    
  }

  //get value
  Future<List<DatabaseModel>> getAllStock() async {
    Database? db = await this.database;
    var result = await db!.query("$_notesTable");
    return List.generate(result.length, (i) {
      return DatabaseModel.fromMap(result[i]);
    });
  }

  Future<List<DatabaseModel>> getAllStockOrderBy(
      {String? orderBy = "asc"}) async {
    Database? db = await this.database;
    var result =
        await db!.query("$_notesTable", orderBy: "$_columnStockName $orderBy");
    return List.generate(result.length, (i) {
      return DatabaseModel.fromMap(result[i]);
    });
  }

  Future<List<DatabaseModel>> getAllStockWhereUpdateDate(
    String begin,
    String end,
  ) async {
    Database? db = await this.database;
    var result = await db!.query("$_notesTable",
        where: "updateDate between ? and ?", whereArgs: [begin, end]);
    return List.generate(result.length, (i) {
      return DatabaseModel.fromMap(result[i]);
    });
  }

// Future<List<DatabaseModel>> getAllStockWhereUpdateDate(
//     String begin,
//     String end,
//   ) async {
//     Database? db = await this.database;
//     var result = await db!.rawQuery("select * from stock where updateDate between '10.10.2021' and '26.10.2021' ");
//     return List.generate(result.length, (i) {
//       return DatabaseModel.fromMap(result[i]);
//     });
//   }

  //insert
  Future<int> insert(DatabaseModel databaseModel) async {
    Database? db = await this.database;
    var result = await db!.insert("$_notesTable", databaseModel.toMap());
    return result;
  }

  //update
  Future<int> update(DatabaseModel databaseModel, int id) async {
    Database? db = await this.database;
    var result = await db!.update("$_notesTable", databaseModel.toMap(),
        where: "id=?", whereArgs: [id]);
    return result;
  }

  //delete
  // Future<int> delete(int id) async {
  //   Database? db = await this.database;
  //   var result = await db!.rawDelete("delete from $_notesTable where id=$id");
  //   return result;
  // }

  Future<int> delete(int id) async {
    Database? db = await this.database;
    var result =
        await db!.rawDelete("delete from $_notesTable where id= ?", [id]);
    return result;
  }

  //stok in out page
  Future<int> incrementUnit(int unit, int id, {String? explanation}) async {
    Database? db = await database;
    int updateCount = explanation.toString().isNotEmpty
        ? await db!.rawUpdate(
            '''
    UPDATE 
      $_notesTable 
    SET 
      $_columnUnit = $_columnUnit + ?,
      $_stockIn = $_stockIn + ?,
      $_columnExplanation = ?
    WHERE 
      $_columnID = ?
    ''',
            [unit, unit, explanation, id],
          )
        : await db!.rawUpdate('''
    UPDATE 
      $_notesTable 
    SET 
      $_columnUnit = $_columnUnit + ?,
      $_stockIn = $_stockIn + ?     
    WHERE 
      $_columnID = ?
    ''', [unit, unit, id]);
    return updateCount;
  }

  Future<int> decrementUnit(int unit, int id, {String? explanation}) async {
    Database? db = await database;
    int updateCount = explanation.toString().isNotEmpty
        ? await db!.rawUpdate(
            '''
    UPDATE 
      $_notesTable 
    SET 
      $_columnUnit = $_columnUnit - ?
      $_stockOut = $_stockOut + ?,
      $_columnExplanation = ?
    WHERE 
      $_columnID = ?
    ''',
            [unit, unit, explanation, id],
          )
        : await db!.rawUpdate('''
    UPDATE 
      $_notesTable 
    SET 
      $_columnUnit = $_columnUnit - ?,
      $_stockOut = $_stockOut + ?     
    WHERE 
      $_columnID = ?
    ''', [unit, unit, id]);
    return updateCount;
  }
}
