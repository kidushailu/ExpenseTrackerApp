import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;


  DatabaseHelper._internal();


  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }


  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }


  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT,
        lastName TEXT,
        email TEXT,
        phone TEXT,
        username TEXT UNIQUE,
        password TEXT
      )
      '''
    );
    await db.execute(
      '''
      CREATE TABLE expenses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        category TEXT,
        amount REAL,
        date TEXT
      )
      '''
    );
    await db.execute(
      '''
      CREATE TABLE budget(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL
      )
      '''
    );
    await db.execute(
      '''
      CREATE TABLE goals(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        amount REAL
      )
      '''
    );
  }


  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('users', user);
  }


  Future<Map<String, dynamic>?> getUser(String username, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return result.isNotEmpty ? result.first : null;
  }


  Future<int> insertExpense(Map<String, dynamic> expense) async {
    Database db = await database;
    return await db.insert('expenses', expense);
  }


  Future<int> updateExpense(int id, Map<String, dynamic> expense) async {
    Database db = await database;
    return await db.update('expenses', expense, where: 'id = ?', whereArgs: [id]);
  }


  Future<int> deleteExpense(int id) async {
    Database db = await database;
    return await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }


  Future<List<Map<String, dynamic>>> getExpenses() async {
    Database db = await database;
    return await db.query('expenses');
  }


  Future<List<Map<String, dynamic>>> getExpensesBetweenDates(DateTime start, DateTime end) async {
    Database db = await database;
    return await db.query(
      'expenses',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
    );
  }


  Future<List<Map<String, dynamic>>> getBudget() async {
    Database db = await database;
    return await db.query('budget');
  }


  Future<List<Map<String, dynamic>>> getGoals() async {
    Database db = await database;
    return await db.query('goals');
  }
}