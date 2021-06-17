import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garden_shop_beta/blocs/auth_bloc.dart';
import 'login.dart';
import 'home.dart' as shop;
import 'upload_firestore.dart' as upload;
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(
    home: new Checkout(),
    routes: <String, WidgetBuilder>{
      '/masuk': (BuildContext context) => new shop.HomeScreen(),
      '/utama': (BuildContext context) => new upload.UploadScreen(),
    },
  ));
}

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout>
    with SingleTickerProviderStateMixin {
  TabController controller;
  StreamSubscription<User> loginStateSubscription;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  List<String> tanaman = [
    "Anggrek",
    "Mawar",
    "Melati",
    "Lidah Buaya",
    "Janda Bolong"
  ];
  String _tanaman = "Mawar";
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
                  backgroundColor: Colors.green,
                  title: Text('Keranjang'),
                  actions: [],
                ),
                backgroundColor: Colors.black38,
                body: Stack(
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('user')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            children: snapshot.data.docs.map((document) {
                              return Card(
                                elevation: 50,
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              document['tanaman'],
                                              style: TextStyle(fontSize: 20.0),
                                            ),
                                            Text(" : "),
                                            Text(
                                              document['harga'].toString(),
                                              style: TextStyle(fontSize: 20.0),
                                            ),
                                            SizedBox(
                                              width: 100,
                                            ),
                                            IconButton(
                                                color: Colors.green,
                                                iconSize: 40,
                                                icon: Icon(Icons
                                                    .monetization_on_outlined),
                                                onPressed: () {}),
                                            IconButton(
                                                iconSize: 40,
                                                color: Colors.red,
                                                icon: Icon(Icons.delete),
                                                onPressed: () {})
                                          ]),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ],
                ));
          }
        });
  }
}
