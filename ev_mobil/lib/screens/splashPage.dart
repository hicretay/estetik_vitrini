import 'package:ev_mobil/settings/consts.dart';
import 'package:ev_mobil/settings/root.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static const route = "/splashPage";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        Navigator.of(context).pop();
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Root()), (route) => false);      
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/splash.jpg"),
        ),
      ),
    );
  }
}
