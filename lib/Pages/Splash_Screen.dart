import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodoffer/Route/route.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';


class AnimatedSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {



  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((pr) {
      prefs=pr;
    });
/*    animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1500));
    animation =
    new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();*/

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }



  var _visible = true;

  /* AnimationController animationController;
  Animation<double> animation;*/

  startTime() async {
    var _duration = new Duration(milliseconds: 3500);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async{
    if(prefs.containsKey('r_name'))
    {
      Navigator.of(context).pushReplacementNamed(HOME);
    }
    else
    {
      Navigator.of(context).pushReplacementNamed(SignIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212b46),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF212b46),Color(0xFF212b46).withOpacity(0.4)],
            ),
          ),
          child: Stack(
            children: <Widget>[

              /*Center(
              *//*child: Image.asset(
                'assets/logo.png',
                width: animation.value * 150,
                height: animation.value * 150,
              ),*//*
              child: ,
            ),*/
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/slash.gif',height: 200),
                    Text(
                      'Food Offer',
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),
                    )

                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
