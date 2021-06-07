import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodoffer/Design/CustomDialog.dart';
import 'package:foodoffer/Route/route.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:foodoffer/api/c_post.dart';
import 'package:foodoffer/Class/save.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../main.dart';

List<String> _locations = ['Burger', 'Pizza', 'Chicken', 'Beef','Rice','Drinks'];
String _selectedcategory; // Option 2

double height, weight;

int max_image;

PostReport postResult = null;

PostReport pm = PostReport();
bool button_state = false;

class Create_Post extends StatefulWidget {
  @override
  _Create_PostState createState() => _Create_PostState();
}

class _Create_PostState extends State<Create_Post> {
  //List<File> IMAGES = new List();
  File IMAGES;
  int now_year = 0, now_date = 0, now_month = 0, now_hour = 0, now_minit = 0;
  String formate;
  bool loading_state = false;

  final food_title = new TextEditingController();
  final food_des = new TextEditingController();
  final food_price = new TextEditingController();
  final food_offer = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey_post =
      new GlobalKey<ScaffoldState>();

  String _food_title, _food_des, _food_price, _category,_food_offer;

  bool _isload = false;

  BuildContext context;

  double height, weight;
  ProgressDialog pr;

  File file;

  void _choose() async {
    //file = await ImagePicker.pickImage(source: ImageSource.camera);
    file = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {});
  }

  void showInSnackBar(String value) {
    _scaffoldKey_post.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    print(_selectedcategory);

    height = MediaQuery.of(context).size.height;
    weight = MediaQuery.of(context).size.width;
    return Scaffold(
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
                        child: Post_Button(),
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
              "Post",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey),
            )),

        Container(
          margin: EdgeInsets.only(left: 10, bottom: 10),
          child: Text(
            'Food Title',
            style: TextStyle(
                color: Colors.white,
                /*   decoration: TextDecoration.underline,
                decorationColor: Colors.red,
                decorationStyle: TextDecorationStyle.wavy,*/
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          child: TextFormField(
            controller: food_title,
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
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
              _food_title = value;
            },
          ),
        ),

        /////////////////////////////////////////////////////////////],
        Padding(
          padding: EdgeInsets.all(5),
        ),
        //////////////////////////////////////////////////////////////

        Container(
          margin: EdgeInsets.only(left: 10, bottom: 10),
          child: Text(
            'Food Description',
            style: TextStyle(
                color: Colors.white,
                /*   decoration: TextDecoration.underline,
                decorationColor: Colors.red,
                decorationStyle: TextDecorationStyle.wavy,*/
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 150,
          child: TextFormField(
            controller: food_des,
            maxLines: 10,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
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
                return 'Please Enter description';
              } else {
                return null;
              }
            },
            onSaved: (String value) {
              _food_des = value;
            },
          ),
        ),

        /////////////////////////////////////////////////////////////
        Padding(
          padding: EdgeInsets.all(5),
        ),
        //////////////////////////////////////////////////////////////

        Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Theme(
                      data: new ThemeData(
                          canvasColor: Colors.grey,
                          primaryColor: Colors.grey,
                          accentColor: Colors.black,
                          hintColor: Colors.white),
                      child: DropdownButtonFormField(
                        isExpanded: false,
                        hint: Text('Choose Category'),
                        iconEnabledColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        value: _selectedcategory,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedcategory = newValue;
                          });
                        },
                        items: _locations.map((location) {
                          return DropdownMenuItem(
                            child: Text(location),
                            value: location,
                          );
                        }).toList(),
                      )),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15, bottom: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Price',
                        style: TextStyle(
                            color: Colors.white,
                            /*   decoration: TextDecoration.underline,
                decorationColor: Colors.red,
                decorationStyle: TextDecorationStyle.wavy,*/
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: food_price,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintStyle:
                              TextStyle(fontSize: 20.0, color: Colors.white),
                          filled: true,
                          fillColor: Colors.grey,
                          enabledBorder: new OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffFFFFFF), width: 2),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Color(0xffE50000)),
                          ),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter price';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String value) {
                          _food_price = value;
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),





        /////////////////////////////////////////////////////////////
        Padding(
          padding: EdgeInsets.all(5),
        ),
        //////////////////////////////////////////////////////////////

        Container(
          margin: EdgeInsets.only(left: 10, bottom: 10),
          child: Text(
            'Food Offer',
            style: TextStyle(
                color: Colors.white,
                /*   decoration: TextDecoration.underline,
                decorationColor: Colors.red,
                decorationStyle: TextDecorationStyle.wavy,*/
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),


        Container(
          height: 50,
          child: TextFormField(
            controller: food_offer,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
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
              ),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please Enter Your offer';
              } else {
                return null;
              }
            },
            onSaved: (String value) {
              _food_offer = value;
            },
          ),
        ),


/*        Container(
          alignment: Alignment.center,
          height: 60,
          width: 100,
          margin: EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: ()async{

              List<File> images = await getMultipleImages(maxImages: 3);

              if(images!=null)
                {
                  IMAGES.addAll(images);
                  print(IMAGES);
                }

              setState(() {

              });
            },
            
            child: Text("Image"),
          ),


        ),*/

        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 50),
          height: 75,
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
        ),


  /*      Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 30),
          height: 60,
          child: ListView.builder(
            itemCount: IMAGES.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Image.file(IMAGES[index]);
            },
          ),
        )*/



      ],
    );
  }

  Widget Post_Button() {
    return GestureDetector(
      onTap: () async {
        GO(context);
        //setState(() {});
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
                "Post",
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

  void Show_Snackbar(String data,var key) {
    key.currentState.showSnackBar(SnackBar(
      content: Text(data),
      duration: Duration(seconds: 3),
    ));
  }

  void GO(BuildContext context) async{
    if (loading_state == false) {
      loading_state = true;
      setState(() {

      });
    }
    var p = await request_Post();

    Map<String, dynamic> jsonResponse = p;
    if (jsonResponse.containsKey("res_name")) {

      Navigator.of(context).pop();
      Navigator.of(context).pushNamedAndRemoveUntil(HOME, (Route<dynamic> route) => false);
    }
  }


  Future request_Post() async {
    now_year = DateTime.now().year;
    now_month = DateTime.now().month;
    now_date = DateTime.now().day;
    now_minit = DateTime.now().minute;

    if (DateTime.now().hour >= 12) {
      now_hour = DateTime.now().hour - 12;
      formate = "PM";
    } else {
      now_hour = DateTime.now().hour;
      formate = "AM";
    }

    String Time = now_hour.toString() + ":" + now_minit.toString() + formate;


    showDialog(context: context,
        barrierDismissible: false,
        child: CustomDialog()
    );

    Map<String,String> bodyFields={
      'res_name': prefs.getString("r_name"),
      'tittle': food_title.text.toString(),
      'description': food_des.text,
      'product_price': food_price.text,
      'category': _selectedcategory,
      'p_location': prefs.getString('res_location'),
      'p_time': Time,
      'offer': food_offer.text.toString(),
    };



    var result;
    var uri = Uri.parse("https://www.pocketshoppingmall.com/food_offer/Medicate/api/c_post");
    var request = new http.MultipartRequest("POST", uri)..fields.addAll(bodyFields);



    if(file!=null){
      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();
      var multipartFile = new http.MultipartFile('p_image', stream, length, filename: basename(file.path));
      request.files.add(multipartFile);
    }
    var response = await request.send();

    await response.stream.transform(utf8.decoder).listen((value) {
      result = value;
    });
    loading_state=false;
    setState(() {

    });
    return json.decode(result);



    //PostReport p = await PostReport.connectToAPI(prefs.getString('r_name'), food_title.text, food_des.text, food_price.text, _selectedcategory,prefs.getString('res_location'),Time,file);


  }
}
