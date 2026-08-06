// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DocumentsTableTable extends DocumentsTable
    with TableInfo<$DocumentsTableTable, DocumentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSignedMeta = const VerificationMeta(
    'isSigned',
  );
  @override
  late final GeneratedColumn<bool> isSigned = GeneratedColumn<bool>(
    'is_signed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_signed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _firstPageImagePathMeta =
      const VerificationMeta('firstPageImagePath');
  @override
  late final GeneratedColumn<String> firstPageImagePath =
      GeneratedColumn<String>(
        'first_page_image_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastPageImagePathMeta = const VerificationMeta(
    'lastPageImagePath',
  );
  @override
  late final GeneratedColumn<String> lastPageImagePath =
      GeneratedColumn<String>(
        'last_page_image_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    filePath,
    createdAt,
    isSigned,
    firstPageImagePath,
    lastPageImagePath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_signed')) {
      context.handle(
        _isSignedMeta,
        isSigned.isAcceptableOrUnknown(data['is_signed']!, _isSignedMeta),
      );
    }
    if (data.containsKey('first_page_image_path')) {
      context.handle(
        _firstPageImagePathMeta,
        firstPageImagePath.isAcceptableOrUnknown(
          data['first_page_image_path']!,
          _firstPageImagePathMeta,
        ),
      );
    }
    if (data.containsKey('last_page_image_path')) {
      context.handle(
        _lastPageImagePathMeta,
        lastPageImagePath.isAcceptableOrUnknown(
          data['last_page_image_path']!,
          _lastPageImagePathMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isSigned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_signed'],
      )!,
      firstPageImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_page_image_path'],
      ),
      lastPageImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_page_image_path'],
      ),
    );
  }

  @override
  $DocumentsTableTable createAlias(String alias) {
    return $DocumentsTableTable(attachedDatabase, alias);
  }
}

class DocumentRow extends DataClass implements Insertable<DocumentRow> {
  final int id;
  final String title;
  final String filePath;
  final DateTime createdAt;
  final bool isSigned;
  final String? firstPageImagePath;
  final String? lastPageImagePath;
  const DocumentRow({
    required this.id,
    required this.title,
    required this.filePath,
    required this.createdAt,
    required this.isSigned,
    this.firstPageImagePath,
    this.lastPageImagePath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['file_path'] = Variable<String>(filePath);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_signed'] = Variable<bool>(isSigned);
    if (!nullToAbsent || firstPageImagePath != null) {
      map['first_page_image_path'] = Variable<String>(firstPageImagePath);
    }
    if (!nullToAbsent || lastPageImagePath != null) {
      map['last_page_image_path'] = Variable<String>(lastPageImagePath);
    }
    return map;
  }

  DocumentsTableCompanion toCompanion(bool nullToAbsent) {
    return DocumentsTableCompanion(
      id: Value(id),
      title: Value(title),
      filePath: Value(filePath),
      createdAt: Value(createdAt),
      isSigned: Value(isSigned),
      firstPageImagePath: firstPageImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(firstPageImagePath),
      lastPageImagePath: lastPageImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPageImagePath),
    );
  }

  factory DocumentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentRow(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      filePath: serializer.fromJson<String>(json['filePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSigned: serializer.fromJson<bool>(json['isSigned']),
      firstPageImagePath: serializer.fromJson<String?>(
        json['firstPageImagePath'],
      ),
      lastPageImagePath: serializer.fromJson<String?>(
        json['lastPageImagePath'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'filePath': serializer.toJson<String>(filePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSigned': serializer.toJson<bool>(isSigned),
      'firstPageImagePath': serializer.toJson<String?>(firstPageImagePath),
      'lastPageImagePath': serializer.toJson<String?>(lastPageImagePath),
    };
  }

  DocumentRow copyWith({
    int? id,
    String? title,
    String? filePath,
    DateTime? createdAt,
    bool? isSigned,
    Value<String?> firstPageImagePath = const Value.absent(),
    Value<String?> lastPageImagePath = const Value.absent(),
  }) => DocumentRow(
    id: id ?? this.id,
    title: title ?? this.title,
    filePath: filePath ?? this.filePath,
    createdAt: createdAt ?? this.createdAt,
    isSigned: isSigned ?? this.isSigned,
    firstPageImagePath: firstPageImagePath.present
        ? firstPageImagePath.value
        : this.firstPageImagePath,
    lastPageImagePath: lastPageImagePath.present
        ? lastPageImagePath.value
        : this.lastPageImagePath,
  );
  DocumentRow copyWithCompanion(DocumentsTableCompanion data) {
    return DocumentRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSigned: data.isSigned.present ? data.isSigned.value : this.isSigned,
      firstPageImagePath: data.firstPageImagePath.present
          ? data.firstPageImagePath.value
          : this.firstPageImagePath,
      lastPageImagePath: data.lastPageImagePath.present
          ? data.lastPageImagePath.value
          : this.lastPageImagePath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('filePath: $filePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSigned: $isSigned, ')
          ..write('firstPageImagePath: $firstPageImagePath, ')
          ..write('lastPageImagePath: $lastPageImagePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    filePath,
    createdAt,
    isSigned,
    firstPageImagePath,
    lastPageImagePath,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.filePath == this.filePath &&
          other.createdAt == this.createdAt &&
          other.isSigned == this.isSigned &&
          other.firstPageImagePath == this.firstPageImagePath &&
          other.lastPageImagePath == this.lastPageImagePath);
}

class DocumentsTableCompanion extends UpdateCompanion<DocumentRow> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> filePath;
  final Value<DateTime> createdAt;
  final Value<bool> isSigned;
  final Value<String?> firstPageImagePath;
  final Value<String?> lastPageImagePath;
  const DocumentsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.filePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSigned = const Value.absent(),
    this.firstPageImagePath = const Value.absent(),
    this.lastPageImagePath = const Value.absent(),
  });
  DocumentsTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String filePath,
    required DateTime createdAt,
    this.isSigned = const Value.absent(),
    this.firstPageImagePath = const Value.absent(),
    this.lastPageImagePath = const Value.absent(),
  }) : title = Value(title),
       filePath = Value(filePath),
       createdAt = Value(createdAt);
  static Insertable<DocumentRow> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? filePath,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSigned,
    Expression<String>? firstPageImagePath,
    Expression<String>? lastPageImagePath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (filePath != null) 'file_path': filePath,
      if (createdAt != null) 'created_at': createdAt,
      if (isSigned != null) 'is_signed': isSigned,
      if (firstPageImagePath != null)
        'first_page_image_path': firstPageImagePath,
      if (lastPageImagePath != null) 'last_page_image_path': lastPageImagePath,
    });
  }

  DocumentsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? filePath,
    Value<DateTime>? createdAt,
    Value<bool>? isSigned,
    Value<String?>? firstPageImagePath,
    Value<String?>? lastPageImagePath,
  }) {
    return DocumentsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      filePath: filePath ?? this.filePath,
      createdAt: createdAt ?? this.createdAt,
      isSigned: isSigned ?? this.isSigned,
      firstPageImagePath: firstPageImagePath ?? this.firstPageImagePath,
      lastPageImagePath: lastPageImagePath ?? this.lastPageImagePath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSigned.present) {
      map['is_signed'] = Variable<bool>(isSigned.value);
    }
    if (firstPageImagePath.present) {
      map['first_page_image_path'] = Variable<String>(firstPageImagePath.value);
    }
    if (lastPageImagePath.present) {
      map['last_page_image_path'] = Variable<String>(lastPageImagePath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('filePath: $filePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSigned: $isSigned, ')
          ..write('firstPageImagePath: $firstPageImagePath, ')
          ..write('lastPageImagePath: $lastPageImagePath')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DocumentsTableTable documentsTable = $DocumentsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [documentsTable];
}

typedef $$DocumentsTableTableCreateCompanionBuilder =
    DocumentsTableCompanion Function({
      Value<int> id,
      required String title,
      required String filePath,
      required DateTime createdAt,
      Value<bool> isSigned,
      Value<String?> firstPageImagePath,
      Value<String?> lastPageImagePath,
    });
typedef $$DocumentsTableTableUpdateCompanionBuilder =
    DocumentsTableCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> filePath,
      Value<DateTime> createdAt,
      Value<bool> isSigned,
      Value<String?> firstPageImagePath,
      Value<String?> lastPageImagePath,
    });

class $$DocumentsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTableTable> {
  $$DocumentsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSigned => $composableBuilder(
    column: $table.isSigned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstPageImagePath => $composableBuilder(
    column: $table.firstPageImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastPageImagePath => $composableBuilder(
    column: $table.lastPageImagePath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DocumentsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTableTable> {
  $$DocumentsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSigned => $composableBuilder(
    column: $table.isSigned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstPageImagePath => $composableBuilder(
    column: $table.firstPageImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastPageImagePath => $composableBuilder(
    column: $table.lastPageImagePath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DocumentsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTableTable> {
  $$DocumentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSigned =>
      $composableBuilder(column: $table.isSigned, builder: (column) => column);

  GeneratedColumn<String> get firstPageImagePath => $composableBuilder(
    column: $table.firstPageImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastPageImagePath => $composableBuilder(
    column: $table.lastPageImagePath,
    builder: (column) => column,
  );
}

class $$DocumentsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTableTable,
          DocumentRow,
          $$DocumentsTableTableFilterComposer,
          $$DocumentsTableTableOrderingComposer,
          $$DocumentsTableTableAnnotationComposer,
          $$DocumentsTableTableCreateCompanionBuilder,
          $$DocumentsTableTableUpdateCompanionBuilder,
          (
            DocumentRow,
            BaseReferences<_$AppDatabase, $DocumentsTableTable, DocumentRow>,
          ),
          DocumentRow,
          PrefetchHooks Function()
        > {
  $$DocumentsTableTableTableManager(
    _$AppDatabase db,
    $DocumentsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isSigned = const Value.absent(),
                Value<String?> firstPageImagePath = const Value.absent(),
                Value<String?> lastPageImagePath = const Value.absent(),
              }) => DocumentsTableCompanion(
                id: id,
                title: title,
                filePath: filePath,
                createdAt: createdAt,
                isSigned: isSigned,
                firstPageImagePath: firstPageImagePath,
                lastPageImagePath: lastPageImagePath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String filePath,
                required DateTime createdAt,
                Value<bool> isSigned = const Value.absent(),
                Value<String?> firstPageImagePath = const Value.absent(),
                Value<String?> lastPageImagePath = const Value.absent(),
              }) => DocumentsTableCompanion.insert(
                id: id,
                title: title,
                filePath: filePath,
                createdAt: createdAt,
                isSigned: isSigned,
                firstPageImagePath: firstPageImagePath,
                lastPageImagePath: lastPageImagePath,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DocumentsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTableTable,
      DocumentRow,
      $$DocumentsTableTableFilterComposer,
      $$DocumentsTableTableOrderingComposer,
      $$DocumentsTableTableAnnotationComposer,
      $$DocumentsTableTableCreateCompanionBuilder,
      $$DocumentsTableTableUpdateCompanionBuilder,
      (
        DocumentRow,
        BaseReferences<_$AppDatabase, $DocumentsTableTable, DocumentRow>,
      ),
      DocumentRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DocumentsTableTableTableManager get documentsTable =>
      $$DocumentsTableTableTableManager(_db, _db.documentsTable);
}
