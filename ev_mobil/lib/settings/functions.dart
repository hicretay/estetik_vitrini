import 'package:estetikvitrini/JsnClass/loginJsn.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String url = "https://service.estetikvitrini.com/api/";

Map<String, String> header = {
  "Content-Type": "application/json",
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Credentials": true.toString(),
  "Access-Control-Allow-Headers":
  "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
  "Access-Control-Allow-Methods": "POST, OPTIONS"
};

Map<String, String> header2 ={
  "access-control-allow-credentials": true.toString(), 
  "access-control-allow-methods": "GET,PUT,POST,DELETE,HEAD,OPTIONS,PATCH,PROPFIND,PROPPATCH,MKCOL,COPY,MOVE,LOCK" ,
  "access-control-allow-origin": "http://service.estetikvitrini.com" ,
  "content-length": 29.toString() ,
  "content-type": "application/json; charset=utf-8" ,
  "date": "Wed,11 Aug 2021 06:49:57 GMT" ,
  "server": "Microsoft-IIS/8.5" ,
  "x-powered-by": "ASP.NET",
};

//---------------------------------------------------Login Fonksiyonu--------------------------------------------------------------
Future<LoginJsn> loginJsnFunc(String userName, String password, bool social) async {
  final response = await http.post(Uri.parse(url + "LoginJsn"),
      body: '{"userName":' +'"$userName"' + ',' +'"password":' + '"$password"' + ',' + '"social":' + social.toString() + '}',
      headers: header,
      );

    if (response.statusCode == 200) {
    if (response.body.contains("true")) {
    final String responseString = response.body;
    return loginJsnFromJson(responseString);  
    }else{
      return null;
    }    
  } else {
    return null;
  }
}
//---------------------------------------------------------------------------------------------------------------------------------



//-----------------------------------------Toast Mesaj Gösterme Fonksiyonu----------------------------------------------------------
showToast(BuildContext context, String content){
  return Toast.show(content, context, backgroundColor: Colors.grey,duration: 3, textColor: Colors.black,gravity: Toast.LENGTH_SHORT);
}
//----------------------------------------------------------------------------------------------------------------------------------

//---------------------------------------Kullanıcıya Dönüt - Uyarı Dialog Fonksiyonu------------------------------------------------
  showAlert(BuildContext context, String content) { 
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content: Text(content, style: TextStyle(fontFamily: contentFont)),
        actions: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center,
           children: [
             MaterialButton(
             color: primaryColor,
             child: Text("Kapat",style: TextStyle(fontFamily: leadingFont)), // fotoğraf çekilmeye devam edilecek
             onPressed: () async{
               Navigator.of(context).pop();
          }),
          ],
           ),
          
        ],
      );
    });
  }
//---------------------------------------------------------------------------------------------------------------------------------