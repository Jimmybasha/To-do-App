import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Style/AppStyle.dart';
import 'package:todoapp/UI/Login/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todoapp/splash/SplashScreen.dart';
import 'UI/Home/Widgets/HomeScreen.dart';
import 'UI/Home/Widgets/tabs/Tasks Tab/EditFormField.dart';
import 'firebase_options.dart';

import 'UI/Register/RegisterScreen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  var user = FirebaseAuth.instance.currentUser;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppStyle.lightTheme,
      themeMode: ThemeMode.light,
      routes: {

        LoginScreen.routeName:(_)=>const LoginScreen(),
        RegisterScreen.routeName:(_)=> RegisterScreen(),
        HomeScreen.routeName:(_)=> HomeScreen(),
        SplashScreen.routeName:(_)=> SplashScreen(),
        EditFormField.routeName: (_)=> EditFormField()

      },
      initialRoute:SplashScreen.routeName
      //user!=null?HomeScreen.routeName:LoginScreen.routeName

    );
  }
}