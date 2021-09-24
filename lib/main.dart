import 'package:flutter/material.dart';
import './home.dart';
import 'dart:async';
//import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Fun Game 2048',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData.dark,
      // A widget which will be started on application startup
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => MyHomePage(title: '2048 Game'))));
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/icon/2048.png', width: 200, height: 200),
            Text(
              "2048 Game",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
