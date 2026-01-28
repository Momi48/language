import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:language/auth/login_screen.dart';
import 'package:language/firebase_options.dart';
import 'package:language/model/user_model.dart';
import 'package:language/screen/home_screen.dart';
import 'package:language/services/firebase_services.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
); 

  runApp(const MyApp());
 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(

      home: 
      //RegisterScreen()
       FutureBuilder<UserModel?>(
        future: AuthService().getLoggedInUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasData && snapshot.data != null) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
    )
      
    );
  }
}
