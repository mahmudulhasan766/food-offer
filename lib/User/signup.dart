import 'package:flutter/material.dart';
import 'package:foodoffer/Design/CustomDialog.dart';
import 'package:foodoffer/Route/route.dart';
import 'package:foodoffer/api/api.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:foodoffer/api/api.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';



String _rName, _OwnName, _rEmail, _rPhone, _rAddress, _rPass, _cPass;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  List<String> _locations = ['A', 'B', 'C', 'D'];
  String _selectedLocation; // Option 2

  PostResult postResult = null;

  PostResult ps = PostResult();
  BuildContext context;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool button_state = false;

  TextEditingController res_name = new TextEditingController();
  TextEditingController res_owner = new TextEditingController();
  TextEditingController res_email = new TextEditingController();
  TextEditingController res_phone = new TextEditingController();
  TextEditingController res_address = new TextEditingController();
  TextEditingController res_pass = new TextEditingController();
  TextEditingController res_cpass = new TextEditingController();

  bool _isload = false;

  double height, weight;
  ProgressDialog pr;

  File file;
  void _choose() async {
    file = await ImagePicker.pickImage(source: ImageSource.camera);
    file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {

    this.context = context;
    /* pr = new ProgressDialog(context);*/

    print(res_name.text);

    height = MediaQuery.of(context).size.height;
    weight = MediaQuery.of(context).size.width;

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
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: weight - 64,
                      color: Colors.teal,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Register_Button(),
                      ),

                    ),
                  )
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
              "Registration",
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
          padding: EdgeInsets.all(5),
        ),
        //////////////////////////////////////////////////////////////

        ResName(),
        /////////////////////////////////////////////////////////////
        Padding(
          padding: EdgeInsets.all(5),
        ),
        //////////////////////////////////////////////////////////////
        ResOwner(),
        /////////////////////////////////////////////////////////////
        Padding(
          padding: EdgeInsets.all(5),
        ),
        //////////////////////////////////////////////////////////////
        ResEmail(),
        /////////////////////////////////////////////////////////////
        Padding(
          padding: EdgeInsets.all(5),
        ),
        //////////////////////////////////////////////////////////////
        ResPhone(),
        /////////////////////////////////////////////////////////////
        Padding(
          padding: EdgeInsets.all(5),
        ),
        //////////////////////////////////////////////////////////////
        ChooseImage(),
        /////////////////////////////////////////////////////////////
        Padding(
          padding: EdgeInsets.all(5),
        ),
        //////////////////////////////////////////////////////////////
        ResAddres(),
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
        RConPass(),
        /////////////////////////////////////////////////////////////
        Padding(
          padding: EdgeInsets.all(5),
        ),
        //////////////////////////////////////////////////////////////


      ],
    );
  }

  Widget Register_Button() {
    return GestureDetector(
      onTap: () async {

        if (_formKey.currentState.validate()) {
          if (res_pass.text == res_cpass.text) {
            GO(context);

          } else {
            showInSnackBar("Password doesn't match");
          }
        }

      },
      child: Container(
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
                "Register",
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
    );
  }

  Widget ResName() {
    return Container(
      //height: 50,
      child: TextFormField(
        controller: res_name,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.fastfood, color: Colors.white),
            hintText: "Restaurant Name",
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
            return 'Please Enter Your Restaurant Name';
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          _rName = value;
        },
      ),
    );
  }

  Widget ResOwner() {
    return Container(
      // height: 50,
      child: TextFormField(
        controller: res_owner,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.recent_actors, color: Colors.white),
          hintText: "Restaurant Owner",
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
            return 'Please Enter Owner Name';
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          _OwnName = value;
        },
      ),
    );
  }

  Widget ResPhone() {
    return Container(
      // height: 50,
      child: TextFormField(
        controller: res_phone,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone_android, color: Colors.white),
          hintText: "Phone Number",
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
            return 'Phone Number required';
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          _rPhone = value;
        },
      ),
    );
  }

  Widget ResEmail() {
    return Container(
      //height: 50,
      child: TextFormField(
        controller: res_email,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email, color: Colors.white),
          hintText: "Email",
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
            return 'Please Enter Your Restaurant Email';
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          _rEmail = value;
        },
      ),
    );
  }

  Widget ResAddres() {
    return Container(
      // height: 50,
      child: TextFormField(
        controller: res_address,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.location_city, color: Colors.white),
          hintText: "Address",
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
            return 'Please Enter Your Restaurant Address';
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          _rAddress = value;
        },
      ),
    );
  }

  Widget ChooseImage() {
    return Container(
      height: 60,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: _choose,
                    child: Text('Choose Image'),
                  ),
                  //SizedBox(width: 10.0,height: 20.0),
                ],
              ),
            ),
          ),
          Expanded(

            child: Container(
                child: file == null
                    ? Text("No image selected")
                    : Text(
                        file.path,
                        maxLines: 2,
                      )),
          )
        ],
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
          prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
          hintText: "Password",
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
            return 'Please Enter Your Password';
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          _rPass = value;
        },
      ),
    );
  }

  Widget RConPass() {
    return Container(
      margin: EdgeInsets.only(bottom: 100),
      //height: 50,
      child: TextFormField(
        controller: res_cpass,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
          hintText: "Confirm Password",
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
            return 'enter Password';
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          _cPass = value;
        },
      ),
    );
  }


  void GO(BuildContext context) async{
   /* if (loading_state == false) {
      loading_state = true;
      setState(() {

      });
    }*/
    var p = await Request_Registration();

    Map<String, dynamic> jsonResponse = p;

    if (jsonResponse.containsKey("r_name")) {

      Store(p);
      Navigator.of(context).pop();
      Navigator.of(context).pushNamedAndRemoveUntil(HOME, (Route<dynamic> route) => false);
    }
  }

  Store(var data) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('r_id', data["id"].toString());
    prefs.setString('r_name', res_name.text);
    prefs.setString('own_name', res_owner.text);
    prefs.setString('email', res_email.text);
    prefs.setString('phone', res_phone.text);
    prefs.setString('res_location', res_address.text);
    prefs.setString('r_banner', file.toString());


    setState(() {});
    /*Navigator.of(context).pop();

    Navigator.of(context).pushNamedAndRemoveUntil(HOME, (Route<dynamic> route) => false);*/
  }

  Future Request_Registration()async {

    showDialog(context: context,
        barrierDismissible: false,
        child: CustomDialog()
    );

    Map<String,String> bodyFields={
      'r_name': res_name.text,
      'own_name': res_owner.text,
      'email': res_email.text,
      'phone': res_phone.text,
      'res_location': res_address.text,
      'password': res_pass.text,};


    var result;
    var uri = Uri.parse("https://www.pocketshoppingmall.com/food_offer/Medicate/api/res_registration");
    var request = new http.MultipartRequest("POST", uri)..fields.addAll(bodyFields);


    if(file!=null){
      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();
      var multipartFile = new http.MultipartFile('r_banner', stream, length, filename: basename(file.path));
      request.files.add(multipartFile);
    }

    var response = await request.send();

    await response.stream.transform(utf8.decoder).listen((value) {
      result = value;
    });

    setState(() {

    });
    return json.decode(result);
    //PostResult p = await PostResult.connectToAPI(res_name.text, res_owner.text, res_email.text, res_phone.text, res_address.text, res_pass.text,file);

  }
}
