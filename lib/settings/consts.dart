import 'package:flutter/material.dart';

BoxDecoration boxDecoration = BoxDecoration(
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.circular(minCurved),
);


BoxDecoration reservationBoxDecoration = BoxDecoration(
  color: tertiaryColor,
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.circular(minCurved),
);

TextStyle leadingTextStyle = TextStyle(
  
);

const primaryColor = Color(0xFF352A4D);
const primaryTransparentColor = Color(0x80352A4D);
const secondaryColor = Color(0xFFD4BDD8);
const secondaryTransparentColor = Color(0x33D4BDD8);
const tertiaryColor = Color(0xff62C6C7);
const darkWhite = Color(0xffE0E1E1);
const lightWhite = Color(0xffF4F4F4);
const white = Colors.white;
const splashColor = Color(0xff8675A2);
const darkBg = Color(0xff1D1D1B);

const backGroundColor1 = [primaryColor, secondaryColor];
const backGroundColor2 = [primaryColor, tertiaryColor];
const backGroundColor3 = [darkWhite, darkWhite];
const backGroundColorDark = [darkBg, darkBg];

const leadingFont = "futura_light_bt";
const contentFont = "futura_medium_bt";
const headerFont = "futura_medium_bt";

deviceHeight(BuildContext context)=>
 MediaQuery.of(context).size.height;
// Cihaz ekran yüksekliği

deviceWidth(BuildContext context)=>
 MediaQuery.of(context).size.width; 
//Cihaz ekran genişliği

const defaultPadding = 16.0;
const cardCurved = 20.0;
const minCurved = 3.0;

const minSpace = 5.0;
const maxSpace = 10.0;

const iconSize = 25.0;

//Global servis ID'leri
int globalCompanyId = 1;
dynamic globalHomeContentId;

var circularBasic = Center(child: CircularProgressIndicator(backgroundColor: primaryColor,valueColor: AlwaysStoppedAnimation<Color>(secondaryColor)));

bool isThemeDark = false;
ThemeData theme = ThemeData();
Color iconCol;
