import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'service.dart/authentication_service.dart';
import 'ui/authentication/loginpage.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

void setupLocator(){
  GetIt.I.registerLazySingleton(()=> AuthenticationService());


  
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piggy Pennies',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
     
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
