import 'package:call_book/homescreen.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (context) => Home(),
        'add' : (context) => Home(),
      },
    ),
  );
}