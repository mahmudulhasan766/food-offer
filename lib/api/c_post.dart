import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:foodoffer/User/signup.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class PostReport {
  String res_name;
  String tittle;
  String description;
  String p_image;
  String product_price;
  String category;
  String p_time;
  String p_location;


  PostReport(
      {
        this.res_name,this.tittle,this.description,this.p_image,this.product_price,this.category,this.p_time,this.p_location
      });


  factory PostReport.createPostResult(Map<String, dynamic> object)
  {
    return PostReport(
      res_name: object['res_name'],
      tittle: object['tittle'],
      description: object['description'],
      p_image: object['p_image'],
      product_price: object['product_price'],
      category: object['category'],
      p_time: object['p_time'],
      p_location: object['p_location'],
    );

  }

  static Future<PostReport> connectToAPI(String res_name, String tittle,String description,String product_price,String category,String p_time,String p_location,File file ) async {
    String apiURL = "https://www.pocketshoppingmall.com/food_offer/Medicate/api/c_post";

    var body = {"res_name": res_name,"tittle":tittle,"description":description,"product_price":product_price,"category":category,"p_time":p_time,"p_location":p_location};
    print(body);
    print(file);
    var apiResult = await http.post(apiURL, body: body);
    var jsonObject = json.decode(apiResult.body);


    var uri = Uri.parse(apiURL);
    var request = new http.MultipartRequest("POST", uri)..fields.addAll(body);


    if(file!=null){
      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();
      var multipartFile = new http.MultipartFile('p_image', stream, length, filename: basename(file.path));
      request.files.add(multipartFile);
    }

    var response = await request.send();

    await response.stream.transform(utf8.decoder).listen((value) {
      jsonObject = value;
    });
    print(jsonObject);


    return PostReport.createPostResult(json.decode(jsonObject));

  }


}