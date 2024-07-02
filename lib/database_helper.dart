import 'package:sqflite/sqflite.dart'; // Import sqflite package for SQLite database operations
import 'package:path/path.dart'; // Import path package for handling file paths

// DatabaseHelper is a singleton class responsible for managing the SQLite database
class DatabaseHelper {
  // Create a single instance of DatabaseHelper using the Singleton pattern
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  // A private variable to hold the reference to the database
  static Database? _database;

  // Private constructor for the Singleton pattern
  DatabaseHelper._internal();

  // Getter for the database instance, initializes it if not already done
  Future<Database> get database async {
    if (_database != null)
      return _database!; // Return existing database if it's already initialized
    _database =
        await _initDatabase(); // Initialize the database if it's not already
    return _database!;
  }

  // Initializes the SQLite database
  Future<Database> _initDatabase() async {
    // Get the path to the database file and join it with the file name
    String path = join(await getDatabasesPath(), 'user_database.db');
    // Open the database and create it if it doesn't exist, using version 1
    return await openDatabase(
      path,
      version: 1, // Database version number
      onCreate:
          _onCreate, // Callback function to create tables on database creation
    );
  }

  // Callback function to create tables when the database is created
  Future _onCreate(Database db, int version) async {
    // Create the 'users' table
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT, // Primary key, auto-incremented
        firstName TEXT, // User's first name
        lastName TEXT, // User's last name
        email TEXT, // User's email
        phone TEXT, // User's phone number
        username TEXT UNIQUE, // User's username, must be unique
        password TEXT // User's password
      )
    ''');

    // Create the 'expenses' table
    await db.execute('''
      CREATE TABLE expenses(
        id INTEGER PRIMARY KEY AUTOINCREMENT, // Primary key, auto-incremented
        name TEXT, // Name of the expense
        category TEXT, // Category of the expense
        amount REAL, // Amount of the expense
        date TEXT // Date of the expense
      )
    ''');

    // Create the 'budget' table
    await db.execute('''
      CREATE TABLE budget(
        id INTEGER PRIMARY KEY AUTOINCREMENT, // Primary key, auto-incremented
        amount REAL // Budget amount
      )
    ''');

    // Create the 'goals' table
    await db.execute('''
      CREATE TABLE goals(
        id INTEGER PRIMARY KEY AUTOINCREMENT, // Primary key, auto-incremented
        title TEXT, // Title of the goal
        amount REAL // Goal amount
      )
    ''');

    // Insert a sample expense into the 'expenses' table
    await db.insert(
      'expenses',
      {'name': 'gas', 'category': 'Gas', 'amount': 20, 'date': '07/01/2024'},
    );
  }

  // Insert a new user into the 'users' table
  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database; // Get the database instance
    return await db.insert(
        'users', user); // Insert the user and return the row ID
  }

  // Retrieve a user from the 'users' table by username and password
  Future<Map<String, dynamic>?> getUser(
      String username, String password) async {
    Database db = await database; // Get the database instance
    // Query the 'users' table to find a user with the given username and password
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ? AND password = ?', // WHERE clause
      whereArgs: [username, password], // Parameters for the WHERE clause
    );
    // Return the first result if available, otherwise return null
    return result.isNotEmpty ? result.first : null;
  }

  // Insert a new budget record into the 'budget' table
  Future<int> insertBudget(Map<String, dynamic> budget) async {
    Database db = await database; // Get the database instance
    return await db.insert(
        'budget', budget); // Insert the budget and return the row ID
  }

  // Insert a new expense record into the 'expenses' table
  Future<int> insertExpense(Map<String, dynamic> expense) async {
    Database db = await database; // Get the database instance
    return await db.insert(
        'expenses', expense); // Insert the expense and return the row ID
  }

  // Update an existing expense record in the 'expenses' table
  Future<int> updateExpense(int id, Map<String, dynamic> expense) async {
    Database db = await database; // Get the database instance
    return await db.update('expenses', expense,
        where: 'id = ?', whereArgs: [id]); // Update the expense
  }

  // Delete a specific expense record from the 'expenses' table
  Future<int> deleteExpense(int id) async {
    Database db = await database; // Get the database instance
    return await db.delete('expenses',
        where: 'id = ?', whereArgs: [id]); // Delete the expense by ID
  }

  // Delete all expense records from the 'expenses' table
  Future<int> deleteAllExpenses() async {
    Database db = await database; // Get the database instance
    return await db.delete('expenses'); // Delete all expenses
  }

  // Retrieve all expense records from the 'expenses' table
  Future<List<Map<String, dynamic>>> getExpenses() async {
    Database db = await database; // Get the database instance
    return await db.query('expenses'); // Query all expenses
  }

  // Retrieve monthly expenses grouped by category
  Future<List<Map<String, dynamic>>> getMonthlyExpenses() async {
    final db = await database; // Get the database instance
    final result = await db.rawQuery('''
    SELECT category, SUM(amount) AS amount
    FROM expenses
    WHERE strftime('%Y-%m', date) = strftime('%Y-%m', 'now') // Filter for the current month
    GROUP BY category // Group by category
  ''');

    // Map the result to ensure the amount is not null
    return result.map((row) {
      final amount =
          (row['amount'] as double?) ?? 0.0; // Ensure amount is valid
      return {
        'category': row['category'], // Category of the expense
        'amount': amount, // Total amount for the category
      };
    }).toList();
  }

  // Retrieve expense records between two dates
  Future<List<Map<String, dynamic>>> getExpensesBetweenDates(
      String start, String end) async {
    Database db = await database; // Get the database instance
    return await db.query(
      'expenses',
      where:
          'date >= ? AND date <= ?', // Filter expenses between start and end dates
      whereArgs: [start, end], // Parameters for the WHERE clause
    );
  }

  // Retrieve expenses grouped by category
  Future<List<Map<String, dynamic>>> getExpensesByCategory() async {
    final db = await database; // Get the database instance
    return await db.rawQuery(
        'SELECT category, SUM(amount) as total FROM expenses GROUP BY category'); // Group by category and sum amounts
  }

  // Retrieve the total amount of all expenses
  Future<double> getTotalExpenses() async {
    final db = await database; // Get the database instance
    final total = await db.rawQuery(
        'SELECT SUM(amount) as total FROM expenses'); // Calculate total expenses
    // Return the total amount or 0.0 if the result is empty
    if (total.isNotEmpty) {
      return total.first['total'] as double? ?? 0.0;
    }
    return 0.0;
  }

  // Retrieve all budget records from the 'budget' table
  Future<List<Map<String, dynamic>>> getBudget() async {
    Database db = await database; // Get the database instance
    return await db.query('budget'); // Query all budgets
  }

  // Retrieve all goal records from the 'goals' table
  Future<List<Map<String, dynamic>>> getGoals() async {
    Database db = await database; // Get the database instance
    return await db.query('goals'); // Query all goals
  }
}
