import 'package:flutter/material.dart';

import 'screens/indexPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Météo',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.blue,
        )
      ),
      debugShowCheckedModeBanner: false,
      home: IndexPage(),
         );
  }
}