import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:estetikvitrini/JsnClass/loginJsn.dart';
import 'package:estetikvitrini/providers/themeDataProvider.dart';
import 'package:estetikvitrini/screens/loginPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/settings/root.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  static const route = "/splashPage";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var connectivityResult = Connectivity().checkConnectivity();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () async{
        Provider.of<ThemeDataProvider>(context, listen: false).loadTheme();
        if(await connectivityResult != ConnectivityResult.none){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? user = prefs.getString("user");
        String? pass = prefs.getString("pass");

        if(user==null){
          Navigator.of(context).pop();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);  
        }
        else{
          // ignore: unused_local_variable
          final LoginJsn? userData = await loginJsnFunc(user, pass!, false); 
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>Root()));
        }
        }

      else{
      showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content: Text("İnternet bağlantınızı kontrol ediniz.", style: TextStyle(fontFamily: contentFont)),
        actions: <Widget>[
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               MaterialButton(
               color: primaryColor,
               child: Text("Kapat",style: TextStyle(fontFamily: leadingFont)), 
               onPressed: () async{
               exit(0);
               }),
             ],
           ),
        ],
      );
    });        
   }
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
