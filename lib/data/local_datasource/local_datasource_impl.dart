import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:signica/data/local_datasource/database/app_database.dart';
import 'package:signica/data/local_datasource/local_datasource.dart';
import 'package:signica/domain/entities/document_entity.dart';

@LazySingleton(as: LocalDatasource)
class LocalDatasourceImpl implements LocalDatasource {
  LocalDatasourceImpl(this._database);

  final AppDatabase _database;

  @override
  Future<DocumentEntity> insertDocument({
    required String title,
    required String filePath,
    String? firstPageImagePath,
    String? lastPageImagePath,
  }) async {
    final createdAt = DateTime.now();
    final id = await _database
        .into(_database.documentsTable)
        .insert(
          DocumentsTableCompanion.insert(
            title: title,
            filePath: p.basename(filePath),
            createdAt: createdAt,
            firstPageImagePath: Value(
              firstPageImagePath == null
                  ? null
                  : p.basename(firstPageImagePath),
            ),
            lastPageImagePath: Value(
              lastPageImagePath == null ? null : p.basename(lastPageImagePath),
            ),
          ),
        );
    return DocumentEntity(
      id: id,
      title: title,
      filePath: filePath,
      createdAt: createdAt,
      firstPageImagePath: firstPageImagePath,
      lastPageImagePath: lastPageImagePath,
    );
  }

  @override
  Stream<List<DocumentEntity>> watchDocuments() {
    final query = _database.select(_database.documentsTable)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    return query.watch().asyncMap(_toEntities);
  }

  @override
  Future<List<DocumentEntity>> getAllDocuments() async {
    final rows = await _database.select(_database.documentsTable).get();
    return _toEntities(rows);
  }

  @override
  Future<List<DocumentEntity>> getDocumentsByIds(List<int> ids) async {
    if (ids.isEmpty) return const [];
    final query = _database.select(_database.documentsTable)
      ..where((t) => t.id.isIn(ids));
    return _toEntities(await query.get());
  }

  @override
  Future<void> deleteDocuments(List<int> ids) async {
    if (ids.isEmpty) return;
    await (_database.delete(
      _database.documentsTable,
    )..where((t) => t.id.isIn(ids))).go();
  }

  @override
  Future<void> setSigned(int id, bool isSigned) async {
    await (_database.update(_database.documentsTable)
          ..where((t) => t.id.equals(id)))
        .write(DocumentsTableCompanion(isSigned: Value(isSigned)));
  }

  @override
  Future<void> clearAllDocuments() async {
    await _database.delete(_database.documentsTable).go();
  }

  Future<List<DocumentEntity>> _toEntities(List<DocumentRow> rows) async {
    final directory = await getApplicationDocumentsDirectory();
    String resolve(String fileName) => p.join(directory.path, fileName);

    return rows
        .map(
          (row) => DocumentEntity(
            id: row.id,
            title: row.title,
            filePath: resolve(row.filePath),
            createdAt: row.createdAt,
            isSigned: row.isSigned,
            firstPageImagePath: row.firstPageImagePath == null
                ? null
                : resolve(row.firstPageImagePath!),
            lastPageImagePath: row.lastPageImagePath == null
                ? null
                : resolve(row.lastPageImagePath!),
          ),
        )
        .toList();
  }
}
