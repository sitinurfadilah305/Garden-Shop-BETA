import 'package:flutter/material.dart';
import 'package:garden_shop_beta/screens/login.dart';
import 'package:splashscreen/splashscreen.dart';
class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5, //mengatur waktu
      navigateAfterSeconds: LoginScreen(),
      title: new Text(
        'Aplikasi Toko Kebutuhan Tanaman Hias',
        style: TextStyle(fontSize: 20),
      ),
      image: Image.asset('image/logo.jpeg'),
      photoSize: 100.0,
    );
  }
}
