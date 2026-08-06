import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:signica/data/datasources/files_picker_datasource.dart';

@LazySingleton(as: FilesPickerDatasource)
class FilesPickerDatasourceImpl implements FilesPickerDatasource {
  @override
  Future<String?> pickPdf() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    return result?.files.single.path;
  }
}
