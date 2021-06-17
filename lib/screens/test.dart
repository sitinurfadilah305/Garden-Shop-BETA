import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garden_shop_beta/blocs/auth_bloc.dart';
import 'login.dart';
import 'package:provider/provider.dart';
import 'item_card.dart' as item;
import 'firestore_data.dart' as data;
import 'tanaman.dart' as tanaman;
import 'checkout.dart' as check;
import 'profile.dart' as profile;

void main() {
  runApp(MaterialApp(
    home: new HomeScreen(),
    routes: <String, WidgetBuilder>{},
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController controllers;
  StreamSubscription<User> loginStateSubscription;

  @override
  void initState() {
    controllers = new TabController(length: 4, vsync: this);
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
    controllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return StreamBuilder<User>(
        stream: authBloc.currentUser,
        builder: (context, snapshot) {
          return Scaffold(
            body: new TabBarView(
              controller: controllers,
              children: <Widget>[
                new tanaman.Tanaman(),
                new item.ShopScreenss(),
                new data.UploadFirestore(),
                new profile.HomeScreen(),
              ],
            ),
            bottomNavigationBar: new Material(
              color: Colors.green,
              child: new TabBar(
                controller: controllers,
                tabs: <Widget>[
                  new Tab(icon: new Icon(Icons.spa_outlined), text: "Tanaman"),
                  new Tab(icon: new Icon(Icons.eco), text: "Pesan"),
                  new Tab(icon: new Icon(Icons.list_alt), text: "Pesanan"),
                  new Tab(
                      icon: new Icon(Icons.account_circle_rounded),
                      text: "Akun"),
                ],
              ),
            ),
          );
        });
  }
}
