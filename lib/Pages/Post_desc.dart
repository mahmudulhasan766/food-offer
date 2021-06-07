import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Post_Description extends StatefulWidget {
  @override
  _Post_DescriptionState createState() => _Post_DescriptionState();
}

class _Post_DescriptionState extends State<Post_Description> {


  @override
  Widget build(BuildContext context) {

   final Map post = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body:SafeArea(
        child:Container(
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Image(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                              "https://pocketshoppingmall.com/food_offer/Medicate/"+post['p_image'],
                            )),
                      ),
                    ),
                    Expanded(
                      child: Container(

                        child: Column(
                          children: <Widget>[
                            SizedBox(
                               height: 60,
                            ),
                            Container(child: Text(post['tittle'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                fontStyle: FontStyle.italic,
                                color: Colors.red),)),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                   /* SizedBox(
                                      width: 10,
                                    ),*/
                                      Container(
                                        padding:EdgeInsets.all(15),
                                          child: Text(post['p_location'])),

                                      Container(

                                          child: Text(post['product_price']+" BDT",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.red),

                                          ))
                                ],
                              ),
                            )

                          ],
                        ),
                      ),

                    )
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(

                padding: EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Text(
                      post['description'],
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ],
                ),
          ))
        ],
      )),
    ));
  }
}
