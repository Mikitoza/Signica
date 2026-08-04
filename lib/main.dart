import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'screens/documents_empty_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LiquidGlassWidgets.initialize();

  runApp(
    LiquidGlassWidgets.wrap(
      child: const SignicaApp(),
      brightnessResolver: Theme.maybeBrightnessOf,
    ),
  );
}

class SignicaApp extends StatelessWidget {
  const SignicaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signica',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF8FE637),
      ),
      home: const DocumentsEmptyScreen(),
    );
  }
}
