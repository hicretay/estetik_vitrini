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


Text leadingText(BuildContext context, String leading) {
  return Text(leading,style: Theme.of(context).textTheme.headline4!.copyWith(color: white, fontFamily: leadingFont));
}

TextStyle reservationText(BuildContext context){
  return TextStyle(fontFamily: leadingFont,fontSize: 17);
}

const primaryColor = Color(0xFF0F0F1E); //Color(0xFF141414); #0F0F1E Ana zemin rengi
const primaryTransparentColor = Color(0x80352A4D);
const secondaryColor = Color(0xFF9C7BAD);
const secondaryTransparentColor = Color.fromARGB(255, 60, 60, 70);//Color(0x339C7BAD);
const tertiaryColor = Color(0xff62C6C7);
const passivePurple =Color.fromARGB(255, 60, 60, 70); // kartların rengi
const lightWhite = Color(0xffF4F4F4); //light mod için kart rengi
const darkWhite = Color(0xffE0E1E1);
const white = Colors.white;
const splashColor = Color(0xff8675A2);
const darkBg = Color(0xff1D1D1B);

const backGroundColor1 = [primaryColor, splashColor];
const backGroundColor2 = [primaryColor, tertiaryColor];
const backGroundColor3 = [primaryColor, primaryColor];
const backGroundColorDark = [darkBg, darkBg];

const leadingFont = "futura_light_bt";
const contentFont = "futura_light_bt";
const headerFont = "futura_light_bt";

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

var circularBasic = Center(child: Padding(
  padding: const EdgeInsets.all(maxSpace),
  child:   CircularProgressIndicator(backgroundColor: primaryColor,valueColor: AlwaysStoppedAnimation<Color>(secondaryColor)),
));

bool isThemeDark = false;
ThemeData theme = ThemeData();
Color? iconCol;
