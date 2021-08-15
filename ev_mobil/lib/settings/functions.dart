import 'package:estetikvitrini/JsnClass/cityJsn.dart';
import 'package:estetikvitrini/JsnClass/contentStreamDetailJsn.dart';
import 'package:estetikvitrini/JsnClass/contentStreamJsn.dart';
import 'package:estetikvitrini/JsnClass/countyJsn.dart';
import 'package:estetikvitrini/JsnClass/favoriCompanyJsn.dart';
import 'package:estetikvitrini/JsnClass/loginJsn.dart';
import 'package:estetikvitrini/JsnClass/userfavoriAreaJsn.dart';
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

//---------------------------------------------------Login Fonksiyonu--------------------------------------------------------------
Future<LoginJsn> loginJsnFunc(String userName, String password, bool social) async {
  final response = await http.post(Uri.parse(url + "LoginJsn"),
      body: '{"userName":' +'"$userName"' + ',' +'"password":' + '"$password"' + ',' + '"social":' + social.toString() + '}',
      headers: header,
      );

    if (response.statusCode == 200) {
    final String responseString = response.body;
    return loginJsnFromJson(responseString);     
  } else {
    return null;
  }
}
//---------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------Ana sayfa postlar Listesi Fonksiyonu-----------------------------------------------
Future<ContentStreamJsn> contentStreamJsnFunc(int id) async {
  final response = await http.post(
    Uri.parse(url + "ContentStream/List"),
    body: '{"userId":' + id.toString() + '}',
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return contentStreamJsnFromJson(responseString);
  } else {
    return null;
  }
}
//---------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------Kampanya Listesi Fonksiyonu--------------------------------------------------------
Future<ContentStreamDetailJsn> contentStreamDetailJsnFunc(int companyId, int campaingId) async {
  final response = await http.post(
    Uri.parse(url + "ContentStreamDetail/List"),
    body: '{"companyId":' + companyId.toString() + ',' + '"campaingId":' + campaingId.toString() + '}',
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return contentStreamDetailJsnFromJson(responseString);
  } else {
    return null;
  }
}
//---------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------Favori Salonlar Listesi Fonksiyonu-------------------------------------------------
Future<FavoriCompanyJsn> favoriCompanyJsnFunc(int id) async {
  final response = await http.post(
    Uri.parse(url + "FavoriCompany/List"),
    body: '{"userId":' + id.toString() + '}',
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return favoriCompanyJsnFromJson(responseString);
  } else {
    return null;
  }
}
//---------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------Favori Konumlar Listesi Fonksiyonu-------------------------------------------------
Future<UserFavoriAreaJsn> userFavoriAreaJsnFunc(int id) async {
  final response = await http.post(
    Uri.parse(url + "UserFavoriArea/List"),
    body: '{"userId":' + id.toString() + '}',
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return userFavoriAreaJsnFromJson(responseString);
  } else {
    return null;
  }
}
//---------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------Şehir Listesi Fonksiyonu-----------------------------------------------------------
Future<CityJsn> cityJsnFunc() async {
  final response = await http.post(
    Uri.parse(url + "City"),
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return cityJsnFromJson(responseString);
  } else {
    return null;
  }
}
//---------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------İlçe Listesi Fonksiyonu-----------------------------------------------------------
Future<CountyJsn> countyJsnFunc(String city) async {
  final response = await http.post(
    Uri.parse(url + "County"),
    body: '{"city":' + city + '}',
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return countyJsnFromJson(responseString);
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