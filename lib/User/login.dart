import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodoffer/Route/route.dart';
import 'package:http/http.dart' as http;
import 'package:foodoffer/Design/CustomDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';



class Sign_In extends StatefulWidget {
  @override
  _Sign_InState createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String r_email, r_pass;
  double height = 0, weight = 0;

  bool button_state = false;
  bool forget_pass_state = false;
  double button_width = 170;

  TextEditingController res_email = new TextEditingController();
  TextEditingController res_pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey,
      body: Form(
          key: _formKey,
          child: Center(
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 40),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.teal),
              child: Stack(
                children: <Widget>[
                  Data(),
                ],
              ),
            ),
          )),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget Data() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Text(
              "Login",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey),
            )),

        /////////////////////////////////////////////////////////////
        Padding(
          padding: EdgeInsets.all(2),
        ),
        //////////////////////////////////////////////////////////////

        ResEmail(),
        /////////////////////////////////////////////////////////////
        Padding(
          padding: EdgeInsets.all(5),
        ),
        //////////////////////////////////////////////////////////////
        ResPass(),
        /////////////////////////////////////////////////////////////
        Padding(
          padding: EdgeInsets.all(5),
        ),
        //////////////////////////////////////////////////////////////

        Align(
          alignment: Alignment.bottomCenter,
          child: Login(),
        ),
      ],
    );
  }

  Widget ResEmail() {
    return Container(
      //height: 50,
      child: TextFormField(
        controller: res_email,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.fastfood, color: Colors.white),
            hintText: "Enter Your Email",
            hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
            filled: true,
            fillColor: Colors.grey,
            enabledBorder: new OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Color(0xffE50000), width: 2),
            )),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Enter Your email';
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          r_email = value;
        },
      ),
    );
  }

  Widget ResPass() {
    return Container(
      // height: 50,
      child: TextFormField(
        controller: res_pass,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.recent_actors, color: Colors.white),
          hintText: "Enter Your Password",
          hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
          filled: true,
          fillColor: Colors.grey,
          enabledBorder: new OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffFFFFFF), width: 2),
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Color(0xffE50000)),
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Enter your password';
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          r_pass = value;
        },
      ),
    );
  }

  Widget Login() {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          showDialog(
            context: context,
            child: CustomDialog(),
          );
          GO();
        }
      },
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            height: 50,
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(SignUp, (Route<dynamic> route) => false);
            },
            child: Container(
              width: 100,
              height: 50,
              margin: EdgeInsets.only(left: 150),
              alignment: Alignment.bottomRight,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Or ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.orange),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Signup",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void Show_Snackbar(String data, var key) {
    key.currentState.showSnackBar(SnackBar(
      content: Text(data),
      duration: Duration(seconds: 3),
    ));
  }

  void GO() async {
    var p = await request_Login();

    button_state = false;
    button_width = 170;

    setState(() {});

    Map<String, dynamic> js = p;
    if (js.containsKey('error')) {
      Show_Snackbar(p['error'], _scaffoldKey);
    } else {
      Store(p, context);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HOME, (Route<dynamic> route) => false);
    }
  }

  Future request_Login() async {
    final response = await http.post(
        'https://www.pocketshoppingmall.com/food_offer/Medicate/api/r_login',
        body: {
          'email': res_email.text,
          'password': res_pass.text,
        });
    Navigator.of(context).pop();
    print(response.body.toString());
    return json.decode(response.body);
  }

  Store(var mat, BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('r_id', mat['user']['ID'].toString());
    prefs.setString('r_name', mat['user']['r_name'].toString());
    prefs.setString('own_name', mat['user']['own_name'].toString());
    prefs.setString('email', mat['user']['email'].toString());
    prefs.setString('phone', mat['user']['phone'].toString());
    prefs.setString('res_location', mat['user']['res_location'].toString());
    prefs.setString('r_banner', mat['user']['r_banner'].toString());

    print(prefs.getString('own_name'));

    button_state = false;
    button_width = 170;
    setState(() {});
    Navigator.of(context)
        .pushNamedAndRemoveUntil(HOME, (Route<dynamic> route) => false);
  }
}
