import 'package:flutter/material.dart';
import 'package:fluttermap/MyApp.dart';
import 'package:fluttermap/screens/landing.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => MyApp(),
          '/landing': (context) => LandingScreen(),
        },
      ),
    );
