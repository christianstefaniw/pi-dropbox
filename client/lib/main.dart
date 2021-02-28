import 'package:client/services.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';

import './config.dart';
import './home.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: currentTheme.currentTheme(),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<Database>(
        future: openDb(),
        builder: (_, AsyncSnapshot<Database> snapshot){
          if (snapshot.hasData){
            return Home(DB(snapshot.data));
          } else {
            return Container(child: Center(child: CircularProgressIndicator(),), color: Colors.white,);
          }
        },
      )
    );
  }
}
