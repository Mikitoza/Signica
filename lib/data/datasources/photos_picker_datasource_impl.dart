import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:signica/data/datasources/photos_picker_datasource.dart';

@LazySingleton(as: PhotosPickerDatasource)
class PhotosPickerDatasourceImpl implements PhotosPickerDatasource {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<List<String>> pickImages() async {
    final images = await _picker.pickMultiImage();
    return images.map((image) => image.path).toList();
  }
}
