import 'package:flutter/material.dart';
import 'package:prueba_ant_pack/constants/global_constants.dart';
import 'package:prueba_ant_pack/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: GlobalConstant.APPNAME,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(239, 72, 97, 1),
        accentColor: Color.fromRGBO(239, 12, 117, 1),
        buttonColor: Color.fromRGBO(254, 183, 2, 1),
        backgroundColor: Color.fromRGBO(238, 231, 234, 1),
        cardColor: Colors.grey,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(239, 76, 88, 1),
        ),
        textTheme: TextTheme(
          headline5: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          bodyText1: TextStyle(
              fontSize: 15,
              color: Colors.grey[500],
              fontStyle: FontStyle.italic),
          button: TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: Container(
            padding: EdgeInsets.all(5),
            child: Image.asset(
              'src/assets/user.png',
              width: 40,
              height: 40,
              // scale: 0.5,
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(GlobalConstant.APPNAME),
        ),
        body: UserPage(),
      ),
    );
  }
}
