import 'package:estetikvitrini/model/story.dart';
import 'package:estetikvitrini/model/company.dart';
import 'package:flutter/material.dart';

Map userObject = {};

BoxDecoration boxDecoration = BoxDecoration(
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.circular(minCurved),
);

const primaryColor = Color(0xFF352A4D);
//const secondaryColor = Color(0xffCBABD1);//8776A2
const secondaryColor = Color(0xFFD4BDD8);
const tertiaryColor = Color(0xff62C6C7);
const darkWhite = Color(0xffE0E1E1);
const lightWhite = Color(0xffF4F4F4);
const white = Colors.white;

const storyColor = [Color(0xffECEDEB), primaryColor];
const backGroundColor1 = [primaryColor, secondaryColor];
const backGroundColor2 = [primaryColor, tertiaryColor];
const backGroundColor3 = [darkWhite, darkWhite];

const leadingFont = "nouvelle_vague_final";
const contentFont = "futura_medium_bt";

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

const iconSize = 30.0;

const aboutText =
    "Alanında uzman, profesyonel kadrosu ile hizmet veren Estecool, kaliteli ve kişiye özel olan hizmet anlayışı ile güzelliğin adresi olan bir kuruluştur. 15 yılı aşkın tecrübesi ile “Kendin için bir şey yap!” sloganı ile hizmet vermeye devam etmektedir. Estecool’un başarısının en büyük anahtarı estetik ve güzellik uygulamalarına dair dünya çapındaki gelişmeleri takip ederek son teknolojik ekipman ve eğitimli personel kadrosu ile siz değerli müşterilerimizin hizmetindeyiz.";
const leading = "Estecool Güzellik Merkezi";

String globalCity = "";
int globalCityId = 1;

final story = [
  Story(
    url:'https://images.unsplash.com/photo-1531299244174-d247dd4e5a66?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=670&q=80',
    caption: 'Salatalı göz hikayesi',
    date: 'şimdi',
  ),
  Story(
    url:'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    caption: 'Cilt Bakımı',
    date:'2 saat önce',
  ),
  Story(
    url: 'https://media.giphy.com/media/FfjiOpMBIWlUBE6rSm/giphy.gif',
    caption: 'Güzellik :)',
    date: '6 saat önce',
  ),
];


final companies = [
  Company(
    name: "Estecool",
    imgUrl:  "https://pbs.twimg.com/profile_images/1081166836635451392/vSiBXHju_400x400.jpg",
    stories: story,
  ),
  Company(
    name: "Epilady",
    imgUrl: "https://is5-ssl.mzstatic.com/image/thumb/Purple114/v4/f8/26/48/f8264838-4211-a3a0-693e-157bd9962202/source/256x256bb.jpg",
    stories: story,
  ),
  Company(
    name: "Estecool",
    imgUrl: "https://pbs.twimg.com/profile_images/1081166836635451392/vSiBXHju_400x400.jpg",
    stories: story,
  ),
  Company(
    name: "Epilady",
    imgUrl: "https://is5-ssl.mzstatic.com/image/thumb/Purple114/v4/f8/26/48/f8264838-4211-a3a0-693e-157bd9962202/source/256x256bb.jpg",
    stories: story,
  ),
    Company(
    name: "Estecool",
    imgUrl: "https://pbs.twimg.com/profile_images/1081166836635451392/vSiBXHju_400x400.jpg",
    stories: story,
  ),
];
