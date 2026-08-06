import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';

part 'app_database.g.dart';

@DataClassName('DocumentRow')
class DocumentsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get filePath => text()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isSigned => boolean().withDefault(const Constant(false))();
  TextColumn get firstPageImagePath => text().nullable()();
  TextColumn get lastPageImagePath => text().nullable()();
}

@lazySingleton
@DriftDatabase(tables: [DocumentsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.withExecutor(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(documentsTable, documentsTable.firstPageImagePath);
        await m.addColumn(documentsTable, documentsTable.lastPageImagePath);
      }
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'signica_db');
  }
}
