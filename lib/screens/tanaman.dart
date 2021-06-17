import 'package:flutter/material.dart';
import 'checkout.dart' as check;
import 'about.dart' as about;
import 'chat.dart' as chat;

class Tanaman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: new AppBar(
        title: new Text("Daftar Tanaman"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new chat.MainPage(),
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
                children: <Widget>[
                  ListTanamankanan(
                    gambar: "image/Ariocarpus.jpeg",
                    judul: "Ariocarpus",
                    deskripsi: "Merupakan sayuran yang mengandung banyak air",
                  ),
                  ListTanamankanan(
                    gambar: "image/Bunga-Anggrek.jpeg",
                    judul: "Anggrek",
                    deskripsi: "Merupakan sayuran yang mengandung banyak air",
                  ),
                  ListTanamankanan(
                    gambar: "image/Bunga-Begonia.jpeg",
                    judul: "Begonia",
                    deskripsi: "Merupakan sayuran yang mengandung banyak air",
                  ),
                  ListTanamankanan(
                    gambar: "image/Bunga-Sepatu.jpeg",
                    judul: "Sepatu",
                    deskripsi: "Merupakan sayuran yang mengandung banyak air",
                  ),
                  ListTanamankanan(
                    gambar: "image/Bunga-Amarilis.jpeg",
                    judul: "Amarilis",
                    deskripsi: "Merupakan sayuran yang mengandung banyak air",
                  ),
                  ListTanamankanan(
                    gambar: "image/Bunga-Geranium.jpeg",
                    judul: "Geranium",
                    deskripsi: "Merupakan sayuran yang mengandung banyak air",
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
            child: new Column(children: <Widget>[
              new Text(
                judul,
                style: new TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              new Text(deskripsi,
                  style: new TextStyle(fontSize: 12.0, color: Colors.blueGrey)),
            ]),
          ),
        ],
      ),
    );
  }
}
