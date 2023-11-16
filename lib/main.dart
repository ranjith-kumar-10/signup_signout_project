import 'dart:async';
import 'package:flutter/material.dart';
import 'package:register_form/homescreen.dart';
import 'package:register_form/signup_signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    getSharedprefDetails();
  }

  Future<void> getSharedprefDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');
    String? savedPassword = prefs.getString('password');
    if (savedEmail != null) {
      if (savedEmail!.isNotEmpty) {
        Timer(
            Duration(seconds: 3),
            () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomeScreen())));
      }
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => SignupScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.network(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrqJAZN6PzPaA1GWCIl5xNIU4kgbWq_AVs9RxcUJiSxm-9HcQlWINqL2Mp63LjJgBsODE&usqp=CAU"),
    );
  }
}
