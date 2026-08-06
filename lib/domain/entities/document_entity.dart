import 'package:equatable/equatable.dart';

class DocumentEntity extends Equatable {
  const DocumentEntity({
    required this.id,
    required this.title,
    required this.filePath,
    required this.createdAt,
    this.isSigned = false,
    this.firstPageImagePath,
    this.lastPageImagePath,
  });

  final int id;
  final String title;
  final String filePath;
  final DateTime createdAt;
  final bool isSigned;
  final String? firstPageImagePath;
  final String? lastPageImagePath;

  @override
  List<Object?> get props => [
    id,
    title,
    filePath,
    createdAt,
    isSigned,
    firstPageImagePath,
    lastPageImagePath,
  ];
}
