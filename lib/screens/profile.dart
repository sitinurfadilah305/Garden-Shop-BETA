import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:garden_shop_beta/blocs/auth_bloc.dart';
import 'login.dart';
import 'shop.dart' as shop;
import 'package:provider/provider.dart';
import 'item_card.dart' as item;
import 'test.dart' as test;
import 'checkout.dart' as check;
import 'about.dart' as about;
import 'chat.dart' as chat;


void main() {
  runApp(MaterialApp(
    home: new HomeScreen(),
    routes: <String, WidgetBuilder>{
      '/masuk': (BuildContext context) => new shop.ShopScreen(),
      '/test': (BuildContext context) => new item.ShopScreenss(),
      '/coba': (BuildContext context) => new test.HomeScreen()
    },
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;
  StreamSubscription<User> loginStateSubscription;

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
    final authBloc = Provider.of<AuthBloc>(context);

    return Scaffold(
        appBar: new AppBar(
          title: new Text("Profil"),
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
        body: Center(
          child: StreamBuilder<User>(
              stream: authBloc.currentUser,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                print(snapshot.data.photoURL);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data.displayName,
                        style: TextStyle(fontSize: 35.0)),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(snapshot.data.email, style: TextStyle(fontSize: 20.0)),
                    SizedBox(
                      height: 20.0,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          snapshot.data.photoURL.replaceFirst('s96', 's400')),
                      radius: 60.0,
                    ),
                    SizedBox(
                      height: 100.0,
                    ),
                    SignInButton(Buttons.Google,
                        text: 'Sign Out of Google',
                        onPressed: () => authBloc.logout()),
                  ],
                );
              }),
        ));
  }
}
