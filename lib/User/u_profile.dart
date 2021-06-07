import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:foodoffer/Class/Profile.dart';
import 'package:foodoffer/Class/Res_Post.dart';
import 'package:foodoffer/Color_me/Color_me.dart';
import 'package:foodoffer/Design/CustomDialog.dart';
import 'package:foodoffer/main.dart';
import 'package:provider/provider.dart';
import 'package:foodoffer/Model/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class U_Profile extends StatefulWidget {
  @override
  _U_ProfileState createState() => _U_ProfileState();
}

class _U_ProfileState extends State<U_Profile> {

  Profile profile;
  List POSTS = new List();
  Res_Post res_post;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState

    get_data(prefs.getString("r_id"));
    get_Post(prefs.getString('r_name'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(

          child: loading
              ? CustomDialog()
              : Column(
            /*mainAxisAlignment: MainAxisAlignment.center,*/
            /*crossAxisAlignment: CrossAxisAlignment.center,*/

            children: <Widget>[
              Stack(
                /*alignment: AlignmentDirectional.center,*/
                overflow: Overflow.visible,
                children: [
                  Image.asset('Image/cover.jpg'),

                  Positioned(
                    bottom: -70,
                    left: 10,
                    child: Container(

                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage('Image/sona.jpg'),
                                radius: 50,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(

                                    margin: EdgeInsets.only(top: 50),
                                    child: Text(prefs.getString('r_name'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),),
                                  ),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_city,
                                      ),

                                      Container(
                                        child: Text(profile.resLocation),
                                      ),

                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 20,
                                      ),

                                      Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text('Call Now',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.blueAccent))

                                      ),

                                    ],
                                  ),

                                ],
                              )


                            ],
                          ),


                        ],


                      ),
                    ),
                  )

                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 100),
                decoration: new BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 2.0, color: Colors.grey),
                    left: BorderSide(width: 2.0, color: Colors.grey),
                    right: BorderSide(width: 2.0, color: Colors.grey),
                    bottom: BorderSide(width: 2.0, color: Colors.grey),),
                ),
              ),

              POSTS!=null?
                  ListView.builder(
                  itemCount: POSTS.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index)
                  {

                    return Column(
                      children: <Widget>[
                        Card(
                          //semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: const EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Stack(
                            children: <Widget>[

                              Container(
                                  color: Color_me.sona,
                                  child:Column(
                                    children: <Widget>[

                                      Container(
                                        margin: EdgeInsets.only(left: 20,top: 10,bottom: 10),
                                        child: Text(POSTS[index]['res_name'],

                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black),

                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        height: 150,
                                        width: 300,

                                        child: Image(
                                            fit: BoxFit.fill,
                                            image: new NetworkImage(

                                              "https://pocketshoppingmall.com/food_offer/Medicate/"+POSTS[index]['p_image'],
                                              /* "https://pocketshoppingmall.com/food_offer/Medicate/assets/images/1598721800_.jpg"*/

                                            )
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10,bottom: 10),
                                        child: Text(POSTS[index]['tittle'],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900, // light
                                            fontStyle: FontStyle.italic, // italic
                                          ),),

                                      ),

                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[

                                                  Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      children:<Widget>[
                                                        Expanded(
                                                          child: Center(
                                                            child: Container(
                                                              child: Text(POSTS[index]['p_location'],
                                                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400// italic
                                                                ),

                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child:Center(
                                                            child:Container(
                                                              child: Text(POSTS[index]['p_time'],
                                                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400// italic
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                        )


                                                      ],

                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child:  Container(

                                                        child: Text(POSTS[index]['product_price']+"BDT",

                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15,
                                                              fontStyle: FontStyle.italic,
                                                              color: Colors.red),


                                                        ),
                                                      ),

                                                    ),
                                                  ),

                                                ],
                                              ),

                                            ],
                                          )
                                      ),

                                      Container(
                                        color: Colors.white70,
                                        height: 30,
                                        child:  Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(

                                                child: Center(
                                                  child: Container(

                                                    child: Text("Like",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w900, // italic
                                                      ),

                                                    ),
                                                  ),
                                                )),

                                            Container(
                                              width: 1,
                                              height: double.maxFinite,
                                              color: Colors.grey,
                                            ),

                                            Expanded(
                                                child: Center(
                                                  child: Container(
                                                    child: Text("Comment",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w900, // italic
                                                      ),

                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ) ,
                                      )



                                    ],

                                  )
                              ),



                              Positioned(
                                  top: 45,
                                  right: 30,
                                  child: Container(

                                    width: 90.0,
                                    height: 90.0,
                                    padding: const EdgeInsets.all(2.0), // borde width
                                    decoration: new BoxDecoration(
                                      //color: Colors.red, // border color
                                      shape: BoxShape.circle,
                                      border: new Border.all(
                                        width: 4.0,
                                        color: Colors.red,
                                      ),


                                    ),

                                    child: Container(
                                        child: Center(
                                          child: new CircleAvatar(
                                              radius: 40,
                                              child: RotationTransition(
                                                turns: new AlwaysStoppedAnimation(20 / 360),
                                                child: new Text(POSTS[index]['offer']+'%\nOff',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                      fontStyle: FontStyle.italic,
                                                      color: Colors.red),

                                                ),
                                              ),

                                              foregroundColor: Colors.red,
                                              backgroundColor: Colors.transparent),
                                        ),
                                        width: 80.0,
                                        height: 80.0,
                                        padding: const EdgeInsets.all(2.0), // borde width
                                        decoration: new BoxDecoration(
                                          //color: Colors.red, // border color
                                          shape: BoxShape.circle,
                                          border: new Border.all(
                                            width: 4.0,
                                            color: Colors.red,
                                          ),
                                        )
                                    ),
                                  )
                              )
                            ],

                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: new BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 0.5, color: Colors.grey),
                              left: BorderSide(width: 0.5, color: Colors.grey),
                              right: BorderSide(width: 0.5, color: Colors.grey),
                              bottom: BorderSide(width: 0.5, color: Colors.grey),),
                          ),
                        ),


                      ],


                    );

                  })
                  :CustomDialog()

            ],

          ),
        )


    );
  }


  Future<List> get_data(var a) async {
    final response =
    await http.get(
        'https://www.pocketshoppingmall.com/food_offer/Medicate/api/user_inf/' +
            a);
    var data = json.decode(response.body);

    print(data);
    profile = Profile.fromJson(data);

    loading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<List> get_post() async {
    final response =
    await http.get(
        'https://www.pocketshoppingmall.com/food_offer/Medicate/api/get_respost/' +
            profile.rName);
    var data = json.decode(response.body);

    print(data);
    res_post = Res_Post.fromJson(data);

    loading = false;
    if (mounted) {
      setState(() {});
    }
  }


  Future<List> get_Post(String x) async {

    final response =
    await http.get('https://www.pocketshoppingmall.com/food_offer/Medicate/api/get_respost/' + x);
    var data = json.decode(response.body) as List;

    POSTS.addAll(data);
    loading = false;

    if(mounted){
      setState(() {});
    }

  }




}
