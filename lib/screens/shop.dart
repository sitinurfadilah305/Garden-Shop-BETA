import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:garden_shop_beta/blocs/auth_bloc.dart';
import 'login.dart';
import 'home.dart' as shop;
import 'upload_firestore.dart' as upload;
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: new ShopScreen(),
    routes: <String, WidgetBuilder>{
      '/masuk': (BuildContext context) => new shop.HomeScreen(),
      '/utama': (BuildContext context) => new upload.UploadScreen(),
    },
  ));
}

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;
  StreamSubscription<User> loginStateSubscription;

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
    final authBloc = Provider.of<AuthBloc>(context);

    return Scaffold(
        body: Center(
      child: StreamBuilder<User>(
          stream: authBloc.currentUser,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            print(snapshot.data.photoURL);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RadioListTile(
                    value: snapshot.data.email,
                    title: Text(snapshot.data.email),
                    groupValue: _Jk,
                    onChanged: (String value) {
                      _pilihJk(value);
                    }),
                Text(snapshot.data.email, style: TextStyle(fontSize: 25.0)),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 100.0,
                ),
                SignInButton(Buttons.Google,
                    text: 'Sign Out of Google',
                    onPressed: () => authBloc.logout()),
                SignInButton(Buttons.Email, text: 'Sign Out of Google',
                    onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new shop.HomeScreen(),
                    ),
                  );
                }),
                SignInButton(Buttons.Hotmail, text: 'Upload', onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new upload.UploadScreen(),
                    ),
                  );
                }),
              ],
            );
          }),
    ));
  }
}
