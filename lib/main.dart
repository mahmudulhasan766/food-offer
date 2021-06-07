import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodoffer/Class/Profile.dart';
import 'package:foodoffer/Color_me/Color_me.dart';
import 'package:foodoffer/Design/background.dart';
import 'package:foodoffer/Pages/Post_desc.dart';
import 'package:foodoffer/Pages/Splash_Screen.dart';
import 'package:foodoffer/Route/route.dart';
import 'package:foodoffer/User/create_post.dart';
import 'package:foodoffer/User/u_profile.dart';
import 'package:http/http.dart' as http;
import 'package:foodoffer/Custom_Icon/my_flutter_app_icons.dart' as Custom_Icon;
import 'package:foodoffer/background.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Design/CustomDialog.dart';
import 'Model/profile.dart';
import 'User/signup.dart';
import 'User/login.dart';
import 'User/create_post.dart';
import 'package:provider/provider.dart';
import 'package:foodoffer/Model/profile.dart';

SharedPreferences prefs;
void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UI()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      routes: <String, WidgetBuilder>{
        HOME: (BuildContext context) => MyHomePage(),
        SignUp: (BuildContext context) => Signup(),
        CreatePost: (BuildContext context) => Create_Post(),
        SPLASH: (BuildContext context) => AnimatedSplashScreen(),
        SignIn: (BuildContext context) => Sign_In(),
        Us_Profile: (BuildContext context) => U_Profile(),
        PostDes: (BuildContext context) => Post_Description(),
      },
      initialRoute: CreatePost,

      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List POSTS = new List();
  bool loading = true;
  Profile profile;

  @override
  void initState() {
    get_posts();
    get_data(prefs.getString('r_id'));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(prefs.getString("r_id"));

    //prefs.clear();
    return Scaffold(
        appBar:
            AppBar(title: Text("Food Offer"), backgroundColor: Color_me.back),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Homepagebackground(
                screenHeight: MediaQuery.of(context).size.height,
              ),
              Container(
                  child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Container(
                      height: 135.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Tab("All Categories", Icons.search),
                          Tab("Burger", Custom_Icon.MyFlutterApp.burger),
                          Tab("Pizza", Custom_Icon.MyFlutterApp.pizza),
                          Tab("Chicken", Custom_Icon.MyFlutterApp.chicken),
                          Tab("Beef", Custom_Icon.MyFlutterApp.beef),
                          Tab("Rice", Custom_Icon.MyFlutterApp.rice),
                          Tab("Drinks", Custom_Icon.MyFlutterApp.drinks),
                          //Tab("Rice"),*/
                        ],
                      )),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  loading
                      ? CustomDialog()
                      : ListView.builder(
                          itemCount: POSTS.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    //Store(movies.results[index].id);
                                    //print(movies.results[index].id);
                                    Navigator.of(context).pushNamed(PostDes,
                                        arguments: POSTS[index]);
                                  },
                                  child: Card(
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
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 20,
                                                      top: 10,
                                                      bottom: 10),
                                                  child: Text(
                                                    POSTS[index]['res_name'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  height: 150,
                                                  width: 300,
                                                  child: Image(
                                                      fit: BoxFit.fill,
                                                      image: new NetworkImage(
                                                        "https://pocketshoppingmall.com/food_offer/Medicate/" +
                                                            POSTS[index]
                                                                ['p_image'],
                                                        /* "https://pocketshoppingmall.com/food_offer/Medicate/assets/images/1598721800_.jpg"*/
                                                      )),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10, bottom: 10),
                                                  child: Text(
                                                    POSTS[index]['tittle'],
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .w900, // light
                                                      fontStyle: FontStyle
                                                          .italic, // italic
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              flex: 2,
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Container(
                                                                        child:
                                                                            Text(
                                                                          POSTS[index]
                                                                              [
                                                                              'p_location'],
                                                                          style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w400 // italic
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Container(
                                                                        child:
                                                                            Text(
                                                                          POSTS[index]
                                                                              [
                                                                              'p_time'],
                                                                          style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w400 // italic
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
                                                                child:
                                                                    Container(
                                                                  child: Text(
                                                                    POSTS[index]
                                                                            [
                                                                            'product_price'] +
                                                                        "BDT",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            15,
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .italic,
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )),
                                                Container(
                                                  color: Colors.white70,
                                                  height: 30,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Expanded(
                                                          child: Center(
                                                        child: Container(
                                                          child: Text(
                                                            "Like",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .w900, // italic
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                      Container(
                                                        width: 1,
                                                        height:
                                                            double.maxFinite,
                                                        color: Colors.grey,
                                                      ),
                                                      Expanded(
                                                          child: Center(
                                                        child: Container(
                                                          child: Text(
                                                            "Comment",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .w900, // italic
                                                            ),
                                                          ),
                                                        ),
                                                      ))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                        Positioned(
                                            top: 45,
                                            right: 30,
                                            child: Container(
                                              width: 90.0,
                                              height: 90.0,
                                              padding: const EdgeInsets.all(
                                                  2.0), // borde width
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
                                                        child:
                                                            RotationTransition(
                                                          turns:
                                                              new AlwaysStoppedAnimation(
                                                                  20 / 360),
                                                          child: new Text(
                                                            POSTS[index]
                                                                    ['offer'] +
                                                                '%\nOff',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                        foregroundColor:
                                                            Colors.red,
                                                        backgroundColor:
                                                            Colors.transparent),
                                                  ),
                                                  width: 80.0,
                                                  height: 80.0,
                                                  padding: const EdgeInsets.all(
                                                      2.0), // borde width
                                                  decoration: new BoxDecoration(
                                                    //color: Colors.red, // border color
                                                    shape: BoxShape.circle,
                                                    border: new Border.all(
                                                      width: 4.0,
                                                      color: Colors.red,
                                                    ),
                                                  )),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: new BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 0.5, color: Colors.grey),
                                      left: BorderSide(
                                          width: 0.5, color: Colors.grey),
                                      right: BorderSide(
                                          width: 0.5, color: Colors.grey),
                                      bottom: BorderSide(
                                          width: 0.5, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          })
                ],
              )),
            ],
          ),
        ),
        drawer: Container(
          width: 250,
          child: Drawer(
            child: loading
                ? Container()
                : ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: 70.0,
                                  height: 70.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage('Image/asf.JPG')))),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                child: Text(
                                  profile.rName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900, // light
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.lightGreen,
                        ),
                      ),
                      ListTile(
                        title: Text('Post'),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                          // Then close the drawer.
                          Navigator.of(context).pushNamed(CreatePost);
                          /*Navigator.pop(context);*/
                        },
                      ),
                      ListTile(
                        title: Text('Profile'),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                          Navigator.of(context).pushNamed(Us_Profile);

                          print(prefs.getString("r_id"));
                        },
                      ),
                      ListTile(
                        title: Text('Logout'),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                          prefs.clear();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              SignIn, (Route<dynamic> route) => false);
                          //Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
          ),
        ));
  }

  Future<List> get_data(String a) async {
    final response = await http.get(
        'https://www.pocketshoppingmall.com/food_offer/Medicate/api/user_inf/' +
            a);
    print(response.body);

    var data = json.decode(response.body.toString());
    print(data);
    profile = Profile.fromJson(data);

    loading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<List> get_posts() async {
    final response = await http.get(
        'http://pocketshoppingmall.com/food_offer/Medicate/api/get_post',
        headers: {"Accept": "application/json"});
    var data = json.decode(response.body) as List;
    POSTS.addAll(data);
    loading = false;
    print(data);
    if (mounted) {
      setState(() {});
    }
    /*   Link = data['next_page_url'];
    _refreshController.refreshCompleted();*/
  }

  Future<List> get_catPost(String x) async {
    final response = await http.get(
        'http://pocketshoppingmall.com/food_offer/Medicate/api/get_catpost/' +
            x,
        headers: {"Accept": "application/json"});
    var data = json.decode(response.body) as List;
    POSTS.addAll(data);
    loading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Widget Tab(String tx, IconData iconData) {
    return GestureDetector(
      onTap: () {
        //Store(movies.results[index].id);
        //print(movies.results[index].id);
        //Navigator.of(context).pushNamed(Sh_Trail,arguments: trailers.results[index]);
        setState(() {
          POSTS.clear();
          if (tx == 'All Categories') {
            get_posts();
          } else {
            get_catPost(tx);
          }
        });
      },
      child: Card(
        //semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.all(10.0),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          height: 100.0,
          width: 100.0,
          child: new Container(
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                color: Color_me.back,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: Colors.white, //                   <--- border color
                  width: 4.0,
                ),
              ),
              child: Container(
                  margin: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        iconData,
                        color: Colors.white,
                        size: 40.0,
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 5),
                          alignment: Alignment.center,
                          child: Text(
                            tx,
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ))),
        ),
      ),
    );
  }
}
