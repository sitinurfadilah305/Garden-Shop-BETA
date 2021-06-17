import 'package:flutter/material.dart';
import 'checkout.dart' as check;
import 'about.dart' as about;

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: new AppBar(
        title: new Text("Tentang Kita"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new check.Checkout(),
                  ),
                );
              }),
          IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new check.Checkout(),
                  ),
                );
              }),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new about.About(),
                  ),
                );
              }),
        ],
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            color: Colors.black26,
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTanamankanan(
                    gambar: "image/ali.jpeg",
                    judul: "Muhammad Ali",
                    deskripsi: "065118092",
                  ),
                  ListTanamankanan(
                    gambar: "image/adi.jpg",
                    judul: "Surya Adi Saputro",
                    deskripsi: "065118107",
                  ),
                  ListTanamankanan(
                    gambar: "image/dila.jpeg",
                    judul: "Siti Nurfadilah",
                    deskripsi: "065118110",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListTanamankanan extends StatelessWidget {
  ListTanamankanan({this.gambar, this.judul, this.deskripsi});

  final String gambar;
  final String judul;
  final String deskripsi;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          new ClipOval(
            child: new Image.asset(
              gambar,
              width: 90.0,
              height: 90.0,
            ),
          ),
          new Container(
            padding: EdgeInsets.all(10.0),
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    judul,
                    style: new TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  new Text(deskripsi,
                      style: new TextStyle(
                          fontSize: 12.0, color: Colors.blueGrey)),
                ]),
          ),
        ],
      ),
    );
  }
}
