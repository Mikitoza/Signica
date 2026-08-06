import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:printing/printing.dart';
import 'package:signica/data/datasources/print_datasource.dart';

@LazySingleton(as: PrintDatasource)
class PrintDatasourceImpl implements PrintDatasource {
  @override
  Future<void> printPdf(String path, {String? name}) async {
    final bytes = await File(path).readAsBytes();
    await Printing.layoutPdf(onLayout: (_) => bytes, name: name ?? 'document');
  }
}
