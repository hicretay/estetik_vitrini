import 'dart:convert';

import 'package:estetikvitrini/JsnClass/addUserCityJsn.dart';
import 'package:estetikvitrini/JsnClass/addUserJsn.dart';
import 'package:estetikvitrini/JsnClass/appointmentAddJsn.dart';
import 'package:estetikvitrini/JsnClass/appointmentDeleteJsn.dart';
import 'package:estetikvitrini/JsnClass/appointmentList.dart';
import 'package:estetikvitrini/JsnClass/cityJsn.dart';
import 'package:estetikvitrini/JsnClass/companyListJsn.dart';
import 'package:estetikvitrini/JsnClass/companyOperationJsn.dart';
import 'package:estetikvitrini/JsnClass/companyOperationTime.dart';
import 'package:estetikvitrini/JsnClass/contentStreamDetailJsn.dart';
import 'package:estetikvitrini/JsnClass/contentStreamJsn.dart';
import 'package:estetikvitrini/JsnClass/countyJsn.dart';
import 'package:estetikvitrini/JsnClass/favoriCompanyJsn.dart';
import 'package:estetikvitrini/JsnClass/likeJsn.dart';
import 'package:estetikvitrini/JsnClass/loginJsn.dart';
import 'package:estetikvitrini/JsnClass/storyContentJsn.dart';
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
Future<ContentStreamJsn> contentStreamJsnFunc(int id, int page) async {
  final response = await http.post(
    Uri.parse(url + "ContentStream/List"),
    body: '{"userId":' + id.toString() + ',' + '"page":' + page.toString() + '}',
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

//----------------------------------------------Favori Salonlar Listesi Fonksiyonu-----------------------------------------------
Future<ContentStreamJsn> favoriteJsnFunc(int userId, int page, bool favorite) async {
  final response = await http.post(
    Uri.parse(url + "ContentStream/List"),
    body: '{"userId":' + userId.toString() + ',' + '"page":' + page.toString() + ',' + '"favorite":' + favorite.toString() + '}', 
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
    body: '{"city":"' + city + '"}',
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return countyJsnFromJson(responseString);
  } else {
    return null;
  }
}
//-------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------Hikayedeki Firmaların Listesi Fonksiyonu-----------------------------------------
Future<CompanyListJsn> companyListJsnFunc() async {
  final response = await http.post(
    Uri.parse(url + "CompanyList"),
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return companyListJsnFromJson(responseString);
  } else {
    return null;
  }
}
//-------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------Hikaye İçeriği Fonksiyonu--------------------------------------------------
Future<StoryContentJsn> storyContentJsnFunc(int id) async {
  final response = await http.post(
    Uri.parse(url + "StoryContentJsn"),
    body: '{"companyId":' + id.toString() + '}',
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return storyContentJsnFromJson(responseString);
  } else {
    return null;
  }
}
//-------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------Kampanyalı İşlemler Fonksiyonu--------------------------------------------------
Future<CompanyOperationJsn> companyOperationJsnFunc(int id) async {
  final response = await http.post(
    Uri.parse(url + "CompanyOperation/List"),
    body: '{"companyId":' + id.toString() + '}',
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return companyOperationJsnFromJson(responseString);
  } else {
    return null;
  }
}
//-------------------------------------------------------------------------------------------------------------------------------


//----------------------------------------------------İşlem Saatleri Fonksiyonu--------------------------------------------------
Future<CompanyOperationTimeJsn> companyOperationTimeJsnFunc(List id) async {
  final response = await http.post(
    Uri.parse(url + "CompanyOperation/Time"),
    body: '{"operationId":' + id.toString() + '}',
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return companyOperationTimeJsnFromJson(responseString);
  } else {
    return null;
  }
}
//----------------------------------------------------------------------------------------------------------------------------

//-----------------------------------------------Randevular Listesi Fonksiyonu-------------------------------------------------
Future<AppointmentListJsn> appointmentListJsnFunc(int userId, String appointmentDate) async {
  final response = await http.post(
    Uri.parse(url + "Appointment/List"),
    body: '{"userId":' + userId.toString() + ',' +  '"appointmentDate":' + '"$appointmentDate"' + '}', 
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return appointmentListJsnFromJson(responseString);
  } else {
    return null;
  }
}
//-----------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------- Randevu Ekleme Fonksiyonu-----------------------------------------------------
Future<AppointmentAddJsn> appointmentAddJsnFunc(int userId, int companyId, int campaingId, String appointmentDate, int appointmentTimeId, int operation, String specialNote) async{
  var bodys ={};
  bodys["userId"]           = userId;
  bodys["companyId"]        = companyId;
  bodys["campaingId"]       = campaingId;
  bodys["appointmentDate"]  = appointmentDate;
  bodys["appointmentTimeId"]= appointmentTimeId;
  bodys["operation"]        = operation;
  bodys["specialNote"]      = specialNote;

  String body = json.encode(bodys);

  final response = await http.post(
    Uri.parse(url + "Appointment/Add"),
    body: body,
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return appointmentAddJsnFromJson(responseString);
  } else {
    print(response.statusCode);
    return null;
  }
}
//-------------------------------------------------------------------------------------------------------------------------

//--------------------------------------------- Randevu Silme Fonksiyonu-----------------------------------------------------
Future<AppointmentDeleteJsn> appointmentDeleteJsnFunc(int id) async{
  var bodys ={};
  bodys["id"] = id;

  String body = json.encode(bodys);

  final response = await http.post(
    Uri.parse(url + "Appointment/Delete"),
    body: body,
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return appointmentDeleteJsnFromJson(responseString);
  } else {
    print(response.statusCode);
    return null;
  }
}
//------------------------------------------------------------------------------------------------------------------------

//---------------------------------------------Kullanıcı Kayıt Fonksiyonu-----------------------------------------------------
Future<AddUserJsn> userAddJsnFunc(String nameSurname, String email, String telephone, String password, String facebookToken, String googleToken) async{
  var bodys ={};
  bodys["nameSurname"]  = nameSurname;
  bodys["email"]        = email;
  bodys["telephone"]    = telephone;
  bodys["password"]     = password;
  bodys["facebookToken"]= facebookToken;
  bodys["googleToken"]  = googleToken;

  String body = json.encode(bodys);

  final response = await http.post(
    Uri.parse(url + "AddUser"),
    body: body,
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return addUserJsnFromJson(responseString);
  } else {
    print(response.statusCode);
    return null;
  }
}
//------------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------Kullanıcı Lokasyon Ekleme Fonksiyonu---------------------------------------------------------------
Future<AddUserCityJsn> userAddCityJsnFunc(int userId, int cityId, int countyId) async{
  var bodys ={};
  bodys["userId"]  = userId;
  bodys["cityId"]  = cityId;
  bodys["countyId"]= countyId;


  String body = json.encode(bodys);

  final response = await http.post(
    Uri.parse(url + "AddUser/City"),
    body: body,
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return addUserCityJsnFromJson(responseString);
  } else {
    print(response.statusCode);
    return null;
  }
}
//-------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------Beğeni Fonksiyonu--------------------------------------------------
Future<LikeJsn> likeJsnFunc(int userId, int campaignId) async{
  var bodys ={};
  bodys["userId"]     = userId;
  bodys["campaignId"] = campaignId;

  String body = json.encode(bodys);

  final response = await http.post(
    Uri.parse(url +  "LikeandShare/Like"),
    body: body,
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return likeJsnFromJson(responseString);
    
  } else {
    print(response.statusCode);
    return null;
  }
}
//-------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------Favorileme Fonksiyonu--------------------------------------------------
Future<LikeJsn> favoriteAddJsnFunc(int userId, int campaignId) async{
  var bodys ={};
  bodys["userId"]     = userId;
  bodys["campaignId"] = campaignId;

  String body = json.encode(bodys);

  final response = await http.post(
    Uri.parse(url + "CompanyList​/Favorite"),
    body: body,
    headers: header
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return likeJsnFromJson(responseString);
    
  } else {
    print(response.statusCode);
    return null;
  }
}
//-------------------------------------------------------------------------------------------------------------------------------

//-----------------------------------------Toast Mesaj Gösterme Fonksiyonu--------------------------------------------------------
showToast(BuildContext context, String content){
  return Toast.show(content, context, backgroundColor: darkWhite,duration: 3, textColor: primaryColor,gravity: Toast.BOTTOM);
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
