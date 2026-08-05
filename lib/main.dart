import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'presentation/documents_screen/documents_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await LiquidGlassWidgets.initialize();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: LiquidGlassWidgets.wrap(
        child: const SignicaApp(),
        brightnessResolver: Theme.maybeBrightnessOf,
      ),
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF4A90E2),
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(fontFamily: 'Inter'),
        ),
      ),
      home: const DocumentsScreen(),
    );
  }
}
