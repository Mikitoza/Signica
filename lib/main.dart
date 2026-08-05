import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'presentation/documents_screen/documents_screen.dart';

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
    return CupertinoApp(
      title: 'Signica',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF4A90E2),
      ),
      home: const DocumentsScreen(),
    );
  }
}
