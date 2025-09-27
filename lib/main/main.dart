import 'package:flutter/material.dart';

import 'package:advanced_flutter/main/factories/ui/pages/next_event_page_factory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.dark);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        dividerTheme: const DividerThemeData(space: 0),
        appBarTheme: AppBarTheme(backgroundColor: colorScheme.primaryContainer),
        brightness: Brightness.dark,
        colorScheme: colorScheme,
        useMaterial3: true,
      ),
      home: makeNextEventPage(),
    );
  }
}
