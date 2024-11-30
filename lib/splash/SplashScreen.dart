import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:todoapp/UI/Home/Widgets/HomeScreen.dart';
import 'package:todoapp/UI/Login/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName="splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState

    Timer(
        Duration(seconds: 3),
      (){
          if(FirebaseAuth.instance.currentUser==null){
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          }else{
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          }
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body:  Center(
          child:  Animate(
            effects: const [
               FadeEffect(

            duration: Duration(
              seconds: 1
            )
               ),
              ScaleEffect(
                  duration: Duration(
                      seconds: 1
                  )
              ),
            ],
            child: Image.asset(
                "assets/images/logo.png",
              height: height*0.5,
              width: width*0.4,
            ),
          ),
        )
    );
  }
}
