import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:orchid_furniture/constants.dart';
import 'package:orchid_furniture/frontend/app/main_page.dart';
import 'package:orchid_furniture/frontend/entry/starter_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: col60,
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(col60))),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => StarterPage(),
        '/main': (context) => const MainPage(),
      },
    );
  }
}
