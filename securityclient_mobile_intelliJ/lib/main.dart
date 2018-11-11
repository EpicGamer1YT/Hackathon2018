import 'dart:io';

import 'package:flutter/material.dart';
import './ui/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'db2',
    options: Platform.isIOS
        ? const FirebaseOptions(
      googleAppID: '1:476918029965:ios:d348f2cdac7f26e5',
      apiKey: "AIzaSyAbF8hFRguIJ7Ng3XerSCK4QlcJGJTbEoc",
      databaseURL: 'https://hackathon2018sugar.firebaseio.com/',
    )
        : const FirebaseOptions(
      googleAppID: '1:476918029965:android:d348f2cdac7f26e5',
      apiKey: 'AIzaSyAbF8hFRguIJ7Ng3XerSCK4QlcJGJTbEoc',
      databaseURL: 'https://hackathon2018sugar.firebaseio.com/',
    ),
  );
  runApp(new MaterialApp(
    title: "VPN Security Client",
    home: Home(app: app),
    routes: <String, WidgetBuilder> {
      Home.routeName : (BuildContext context) => new Home(),
    },
  ));

}



