import 'package:category/category_dao.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'category_database.g.dart';

class Category extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
}

@DriftDatabase(tables: [Category], daos: [CategoryDao])
class CategoryDatabase extends _$CategoryDatabase {
  // we tell the database where to store the data with this constructor
  CategoryDatabase(NativeDatabase nativeDatabase) : super(_openConnection());

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
