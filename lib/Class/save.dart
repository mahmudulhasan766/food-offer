import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Save{
  static SharedPreferences prefs;
  static File _image;

  static var Update_Category_info;

  static bool is_new=false;
  static int delay=3;
  static var Post_Data;

  static File get image => _image;

  static set image(File value) {
    _image = value;
  }
}