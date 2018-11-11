import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:convert';
class Home extends StatefulWidget {
  final FirebaseApp app;
  Home({this.app});
  static final String routeName = '/home';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeState();
  }

}

class HomeState extends State<Home>{
  double _sliderHeight = 2.5;
  double _sliderRound = 2.5;
  String text = "";
  String text2 = "";
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final flutterWebviewPlugin = new FlutterWebviewPlugin();
    flutterWebviewPlugin.dispose();
    flutterWebviewPlugin.launch("http://10.8.0.6:8082/0/detection/pause",
        rect: new Rect.fromLTWH(
            20.0,
            150.0,
            370.0,
            240.0));
    getData();
    getDataHumid();
    return new Scaffold(
      appBar: new AppBar(
        
      ),
      body: new ListView(
        children: <Widget>[
          new Padding(padding: EdgeInsets.all(165.0)),
          new Slider(min: 2.5, max: 12.5, value: _sliderHeight, onChanged: (double value) {
            setState(() {
              _sliderHeight = value;
              print("VALUE: ${((value*100).round())/100}");
            },);
            FirebaseUpdate(((value*100).round())/100, "heightPos");
          }, label: "${((_sliderHeight*100).round())/100}",),
          new Padding(padding: EdgeInsets.all(10.0)),
          new Slider(min: 2.5, max: 12.5, value: _sliderRound, onChanged: (double value) {
            setState(() {
              _sliderRound = value;
              print("VALUE: ${((value*100).round())/100}");
            },);
            FirebaseUpdate(((value*100).round())/100, "roundPos");
          }, label: "${((_sliderRound*100).round())/100}",),
          
          new ListTile(title: new Text("Current Temperature", textAlign: TextAlign.center, style: new TextStyle(fontSize: 30.0),),subtitle: new Text("$text", textAlign: TextAlign.center, style: new TextStyle(fontSize: 25.0),),),
          new ListTile(title: new Text("Current Humidity", textAlign: TextAlign.center, style: new TextStyle(fontSize: 30.0),),subtitle: new Text("$text2", textAlign: TextAlign.center, style: new TextStyle(fontSize: 25.0),),),

        ],
      ),
    );
  }
  void FirebaseUpdate(double value, String place) async {
    final FirebaseDatabase database = new FirebaseDatabase(app: widget.app);
    database.reference().child(place).set("$value");
  }
  Future<void> getData() async {
    final FirebaseDatabase database = new FirebaseDatabase(app: widget.app);
    print("Getting data");
    DataSnapshot snapshot = await database.reference().child("temperature").child("current_inside").once();
    print(snapshot.value);
    if (snapshot.value != null) {
      print(snapshot.value);
      setState(() {
        text = snapshot.value.toString();
        print(snapshot.value);
      });
    }
  }
  Future<void> getDataHumid() async {
    final FirebaseDatabase database = new FirebaseDatabase(app: widget.app);
    print("Getting data");
    DataSnapshot snapshot = await database.reference().child("humidity").child("current_inside").once();
    print(snapshot.value);
    if (snapshot.value != null) {
      print(snapshot.value);
      setState(() {
        text2 = snapshot.value.toString();
        print(snapshot.value);
      });
    }
  }
}