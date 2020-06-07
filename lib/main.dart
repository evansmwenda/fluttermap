import 'package:flutter/material.dart';
import 'package:fluttermap/MyApp.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => MyApp(),
        },
      ),
    );
