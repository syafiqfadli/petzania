import 'package:flutter/material.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Ambit"),
      home: const HomePage(),
    );
  }
}
