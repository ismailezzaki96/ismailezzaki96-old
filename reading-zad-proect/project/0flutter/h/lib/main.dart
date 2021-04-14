import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
 
    runApp(MyApp());
 }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weekly Flutter Challenge 4",
      home: MainPage(),
    );
  }
}
