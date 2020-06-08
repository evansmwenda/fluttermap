import 'package:flutter/material.dart';
import 'package:fluttermap/MyApp.dart';
import 'package:fluttermap/screens/landing.dart';
import 'package:fluttermap/screens/my_tester.dart';
import 'package:fluttermap/screens/pick_location.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => MyApp(),
          '/landing': (context) => LandingScreen(),
          '/picklocation': (context) => PickLocation(),
          '/tester': (context) => MyTester(),
        },
      ),
    );
