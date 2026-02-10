import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/login.dart';
import 'package:mini_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Splashscreen extends StatefulWidget{
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final supabase= Supabase.instance.client;
  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 3),(){

      if(supabase.auth.currentSession == null) {//////////////////Is user already looged in..... Tell me.
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Loginpage()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => MyHomePage(title: "Your's Data")));
      }
    }

    );
  }
  @override
  Widget build(BuildContext context) {
 return Scaffold(
   body: Container(
     width: double.infinity,
     height: double.infinity,
     color: Colors.deepPurple.shade200,
     child: Center(
       child: CircleAvatar(
         backgroundColor: Colors.deepPurple.shade400,
       maxRadius: 130,
         child: Center(
           child: Text("Welcome to Notes Keeper",
             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),

           ),
         ),
       ),
     ),
     ),

 );
  }
}