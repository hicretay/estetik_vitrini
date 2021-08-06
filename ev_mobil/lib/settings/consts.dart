import 'package:ev_mobil/model/story.dart';
import 'package:ev_mobil/model/users.dart';
import 'package:flutter/material.dart';

BoxDecoration boxDecoration = BoxDecoration(
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.circular(minCurved),
);

const primaryColor = Color(0xFF352A4D);
const secondaryColor = Color(0xffCBABD1);
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

const carouselImage = [
  "https://www.1mg.com/articles/wp-content/uploads/2020/12/skincare-woman.jpg",
  "https://ankaramoonlight.com/wp-content/uploads/2017/05/hydrafacial-moonlight.jpg",
  "https://firsat.me/img/big1024/13915_58bd7db143d63_980x400.png",
  "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/flawlessskin-1589384044.png"
];

const posts =[
  {
    "id" : 0,
    "img" :"https://www.1mg.com/articles/wp-content/uploads/2020/12/skincare-woman.jpg",
  },
  {
    "id" : 1,
    "img" : "https://www.dsm.com/personal-care/en_US/formulations/facial-skin-care/nourishing-barrier-skin-care-cream.thumb.800.480.png",
  },
  {
    "id" : 2,
    "img" :   "https://www.lynskincare.com/wp-content/uploads/2021/04/lyn-skincare-senin-en-iyi-halin.jpg",
  }
];

final story = [
  Story(
    mediaType: MediaType.image,
    url:'https://images.unsplash.com/photo-1531299244174-d247dd4e5a66?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=670&q=80',
    caption: 'Salatalı göz hikayesi',
    date: 'şimdi',
  ),
  Story(
    mediaType: MediaType.image,
    url:'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    caption: 'Cilt Bakımı',
    date:'2 saat önce',
  ),
  Story(
    mediaType: MediaType.image,
    url: 'https://media.giphy.com/media/FfjiOpMBIWlUBE6rSm/giphy.gif',
    caption: 'Güzellik :)',
    date: '6 saat önce',
  ),
  Story(
    mediaType: MediaType.text,
    caption: 'İzlediğiniz için teşekkürler...',
    color: Colors.purple,
    date: '8 saat önce',
  ),
];

final stories2 = [
  Story(
    mediaType: MediaType.image,
    url:
        'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    caption: 'Başlıkk',
    date: '1 saat önce',
  ),
  Story(
    mediaType: MediaType.image,
    url:'https://images.unsplash.com/photo-1531299244174-d247dd4e5a66?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=670&q=80',
    caption: 'Totally Cool',
    date: '2 saat önce',
  ),
  Story(
    mediaType: MediaType.image,
    url: 'https://media.giphy.com/media/MNolM0COeDjQQ/giphy.gif',
    caption: 'Estecool',
    date: '2 saat önce',
  ),
  Story(
    mediaType: MediaType.text,
    caption: 'İzlediğiniz için teşekkürler...',
    color: Colors.purple,
    date: 'Şimdi',
  ),
];


final users = [
  User(
    name: "Estecool",
    imgUrl:  "https://pbs.twimg.com/profile_images/1081166836635451392/vSiBXHju_400x400.jpg",
    stories: story,
  ),
  User(
    name: "Epilady",
    imgUrl: "https://is5-ssl.mzstatic.com/image/thumb/Purple114/v4/f8/26/48/f8264838-4211-a3a0-693e-157bd9962202/source/256x256bb.jpg",
    stories: stories2,
  ),
  User(
    name: "Estecool",
    imgUrl: "https://pbs.twimg.com/profile_images/1081166836635451392/vSiBXHju_400x400.jpg",
    stories: story,
  ),
  User(
    name: "Epilady",
    imgUrl: "https://is5-ssl.mzstatic.com/image/thumb/Purple114/v4/f8/26/48/f8264838-4211-a3a0-693e-157bd9962202/source/256x256bb.jpg",
    stories: stories2,
  ),
    User(
    name: "Estecool",
    imgUrl: "https://pbs.twimg.com/profile_images/1081166836635451392/vSiBXHju_400x400.jpg",
    stories: story,
  ),
];
