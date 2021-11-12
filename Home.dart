import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter_shortener/bitly_shortener.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController inlink = TextEditingController();

  TextEditingController slink = TextEditingController();

  String url = "";

  void Clipboard() {
    FlutterClipboard.copy(slink.text);
    slink.text = "";
    Fluttertoast.showToast(
        msg: "Link Copied To Clipboard!",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.blue);
  }

  void short() async {
    final shortener =
        BitLyShortener(accessToken: "e15033cc94e1868a8c06fe356b61b49295ccb4fa");
    final linkData = await shortener.generateShortLink(longUrl: inlink.text);
    print(linkData.link);
    setState(() {
      slink.text = linkData.link.toString();
    });
    Fluttertoast.showToast(
        msg: "URL Shortened!",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.blue);
  }

  void clear() {
    inlink.text = "";
    slink.text = "";
    Fluttertoast.showToast(
    msg: "Cleared All Fields!",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.blue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.blue,
        title: Text("URL Shortner"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.all(35),
                child: TextField(
                  controller: inlink,
                  style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.link_sharp,
                      color: Colors.blue,
                    ),
                    labelText: "Enter URL",
                    labelStyle: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.blue,
                            width: 3.0),
                        borderRadius: BorderRadius.circular(50)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 3.0),
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(35),
                child: TextField(
                  controller: slink,
                  style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.link_sharp,
                      color: Colors.blue,
                    ),
                    labelText: "Shorterned URL",
                    labelStyle: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.blue,
                            width: 3.0),
                        borderRadius: BorderRadius.circular(50)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 3.0),
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            RaisedButton.icon(
              onPressed: () {
                short();
              },
              icon: Icon(Icons.add_link_sharp),
              label: Text("     Short Link        ",
                  style: TextStyle(color: Colors.white)),
              elevation: 25,
              color: Colors.blue,
              shape: StadiumBorder(side: BorderSide(width: 2)),
            ),
            SizedBox(height: 30),
            RaisedButton.icon(
              onPressed: () {
                Clipboard();
              },
              icon: Icon(Icons.content_copy_rounded),
              label: Text(
                "       Copy To Clipbord       ",
                style: TextStyle(color: Colors.white),
              ),
              elevation: 25,
              color: Colors.blue,
              shape: StadiumBorder(side: BorderSide(width: 2)),
            ),
            SizedBox(height: 30),
            RaisedButton.icon(
              onPressed: () {
                clear();
              },
              icon: Icon(Icons.clear),
              label: Text("     Clear All        ",
                  style: TextStyle(color: Colors.white)),
              elevation: 25,
              color: Colors.blue,
              shape: StadiumBorder(side: BorderSide(width: 2)),
            ),
          ],
        ),
      ),
    );
  }
}
