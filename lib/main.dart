import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'injector.dart' as injector;
import 'src/features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  injector.init();
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
