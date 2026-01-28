import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteService {
  Database? database;

  Future<Database> getDatabase() async {
    //data is already avaialbe on databse so we dont need to duplicate
    //our data instead return the old database
    if (database != null) {
      return database!;
    }
    var databasesPath = await getApplicationDocumentsDirectory();
    String path = join(databasesPath.path, 'user.db');

    database = await openDatabase(path, version: 1, onCreate: onCreate);
    return database!;
  }

  onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE translated_sentence (
      userId INTEGER PRIMARY KEY AUTOINCREMENT, 
      translation TEXT
      )
    ''');
  }

  
}
