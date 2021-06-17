import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garden_shop_beta/blocs/auth_bloc.dart';
import 'login.dart';
import 'home.dart' as shop;
import 'upload_firestore.dart' as upload;
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'checkout.dart' as check;
import 'about.dart' as about;
import 'chat.dart' as chat;



void main() {
  runApp(MaterialApp(
    home: new ShopScreenss(),
    routes: <String, WidgetBuilder>{
      '/masuk': (BuildContext context) => new shop.HomeScreen(),
      '/utama': (BuildContext context) => new upload.UploadScreen(),
    },
  ));
}

class ShopScreenss extends StatefulWidget {
  @override
  _ShopScreenssState createState() => _ShopScreenssState();
}

class _ShopScreenssState extends State<ShopScreenss>
    with SingleTickerProviderStateMixin {
  TabController controller;
  StreamSubscription<User> loginStateSubscription;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  List<String> tanaman = [
    "Ariocarpus",
    "Anggrek",
    "Begonia",
    "Sepatu",
    "Amarilis",
    "Geranium"
  ];
  String _tanaman = "Ariocarpus";
  void pilihtanaman(String value) {
    setState(() {
      _tanaman = value;
    });
  }

  List<String> ukuran = [
    "30.000",
    "50.000",
    "75.000",
    "100.000",
  ];
  String _ukuran = "30.000";
  void pilihukuran(String value) {
    setState(() {
      _ukuran = value;
    });
  }

  String _Jk = "";
  void _pilihJk(String value) {
    setState(() {
      _Jk = value;
    });
  }

  @override
  void initState() {
    controller = new TabController(length: 1, vsync: this);
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('user');
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('user').snapshots();

    final authBloc = Provider.of<AuthBloc>(context);

    return StreamBuilder<User>(
        stream: authBloc.currentUser,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          print(snapshot.data.photoURL);
          {
            return Scaffold(
              appBar: AppBar(
                title: Text("Formulir Pembelian"),
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
              body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: <Widget>[
                      RadioListTile(
                        value: snapshot.data.email,
                        title: Text(snapshot.data.email),
                        groupValue: _Jk,
                        onChanged: (String value) {
                          _pilihJk(value);
                        },
                        subtitle: Text("Pilih ini untuk memasukan email anda"),
                      ),
                      TextField(
                        style: GoogleFonts.poppins(),
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: "Nama Penerima",
                            labelText: "Nama Penerima",
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(20.0))),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        style: GoogleFonts.poppins(),
                        controller: ageController,
                        decoration: InputDecoration(
                            hintText: "Alamat",
                            labelText: "Alamat",
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(20.0))),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: <Widget>[
                          Text("Pilih Tanaman"),
                        ],
                      ),
                      Center(
                        child: DropdownButton(
                          onChanged: (String value) {
                            pilihtanaman(value);
                          },
                          value: _tanaman,
                          items: tanaman.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text("Pilih Ukuran"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButton(
                            onChanged: (String value) {
                              pilihukuran(value);
                            },
                            value: _ukuran,
                            items: ukuran.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Container(
                        height: 130,
                        width: 130,
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            color: Colors.blue[900],
                            child: Text(
                              'Add Data',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              //// ADD DATA HERE
                              users.add({
                                'name': nameController.text,
                                'email': _Jk,
                                'tanaman': _tanaman,
                                'harga': _ukuran,
                                'age': int.tryParse(ageController.text) ?? 0
                              });
                              nameController.text = '';
                              ageController.text = '';
                            }),
                      )
                    ],
                  )),
            );
          }
        });
  }
}
