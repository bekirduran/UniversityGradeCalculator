import 'package:flutter/material.dart';

import 'View/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal.shade300
      ),
      title: 'Flutter Demo',

      home: MainPage()
    );
  }
}

