import 'package:flutter/material.dart';
import 'package:language/auth/login_screen.dart';
import 'package:language/model/user_model.dart';
import 'package:language/screen/home_screen.dart';
import 'package:language/services/sqflite_service.dart';

void main() async {
  
  runApp(const MyApp());
 // await SqfliteService().deleteDatabaseData();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<UserModel?>(
        future: SqfliteService().getLoggedInUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasData && snapshot.data != null) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
