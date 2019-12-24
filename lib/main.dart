import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:last_one/pages/test.dart';

void main() async{

  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TestPage(),
  ));
}
