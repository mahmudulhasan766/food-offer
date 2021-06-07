import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:foodoffer/User/signup.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class PostResult {
  String ID;
  String r_name;
  String own_name;
  String email;
  String phone;
  String res_location;
  String r_banner;
  String password;
  String id;


  PostResult(
      {
      this.ID,this.r_name,this.own_name,this.email,this.phone,this.res_location,this.r_banner,this.password
});


  factory PostResult.createUserResult(Map<String, dynamic> object)
  {
   return PostResult(
     ID: object['ID'],
     r_name: object['r_name'],
     own_name: object['own_name'],
     email: object['email'],
     phone: object['phone'],
     res_location: object['res_location'],
     r_banner: object['r_banner'],
     password: object['password'],
    );

  }

  static Future<PostResult> connectToAPI(String r_name, String own_name,String email,String phone,String res_location,String password,File file ) async {
    String apiURL = "https://www.pocketshoppingmall.com/food_offer/Medicate/api/res_registration";

    var body = {"r_name": r_name,"own_name":own_name,"email":email,"phone":phone,"res_location":res_location,"password":password};
    //print(body);
    print(file);
    var apiResult = await http.post(apiURL, body: body);
    var jsonObject = json.decode(apiResult.body);


    var uri = Uri.parse(apiURL);
    var request = new http.MultipartRequest("POST", uri)..fields.addAll(body);


    if(file!=null){
      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();
      var multipartFile = new http.MultipartFile('r_banner', stream, length, filename: basename(file.path));
      request.files.add(multipartFile);
    }

    var response = await request.send();

    await response.stream.transform(utf8.decoder).listen((value) {
      jsonObject = value;
    });

    print(jsonObject);

    return PostResult.createUserResult(json.decode(jsonObject));

  }


}