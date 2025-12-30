import 'package:flutter/material.dart';
import 'package:language/auth/login_screen.dart';
import 'package:language/model/user_model.dart';
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
      CREATE TABLE users (userId INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT,password TEXT, email TEXT,profileImage TEXT,isLoggedIn INTEGER DEFAULT 0,doNotShowAgain INTEGER DEFAULT 0)
    ''');
  }

  Future<UserModel> register({
    required UserModel user,
    required BuildContext context,
  }) async {
    final db = await getDatabase();
    print("data is ");
    int id = await db.insert("users", user.toJson());
    user.userId = id;

    print("user is ${user.toJson()}");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );

    return user;
  }

  Future<UserModel?> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final db = await getDatabase();
      print("Database opened");

      // Query the user
      final List<Map<String, dynamic>> result = await db.query(
        "users",
        where: "email = ? AND password = ?",
        whereArgs: [email.trim(), password.trim()],
      );

      if (result.isNotEmpty) {
        // Convert first result to UserModel
        final user = UserModel.fromJson(result.first);

        await db.update(
          "users",
          {'isLoggedIn': 1},
          where: "userId = ?",
          whereArgs: [user.userId],
        );
        print('User logged in: ${user.toJson()}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
        return user;
      } else {
        print("No user found with given email and password");
        return null;
      }
    } catch (e, stacktrace) {
      print("Login error: $e");
      print(stacktrace);
      return null;
    }
  }

  Future<UserModel?> getLoggedInUser() async {
    final db = await getDatabase();
    final result = await db.query(
      'users',
      where: 'isLoggedIn = ?',
      whereArgs: [1],
    );

    if (result.isNotEmpty) {
      return UserModel.fromJson(result.first);
    }
    return null;
  }

  

  Future<void> deleteDatabaseData() async {
    try {
      // Get app documents directory
      final databasesPath = await getApplicationDocumentsDirectory();
      final path = join(databasesPath.path, 'user.db');

      // Delete the database
      await deleteDatabase(path);

      print('Database deleted successfully');
    } catch (e) {
      print('Error deleting database: $e');
    }
  }
}
