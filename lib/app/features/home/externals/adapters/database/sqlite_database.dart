import 'package:challenge/app/features/home/externals/adapters/database/database.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDatabase implements IDatabase<Database> {
  @override
  Future<Database> openConnection() async {
    final database = await openDatabase('foods_default.db');
    return database;
  }
}
