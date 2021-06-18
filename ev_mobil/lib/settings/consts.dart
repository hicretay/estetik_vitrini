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
 MediaQuery.of(context).size.width;
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

const stories = [
  {
    "id": 1,
    "img":
        "https://www.1mg.com/articles/wp-content/uploads/2020/12/skincare-woman.jpg",
    "icon":
        "https://pbs.twimg.com/profile_images/1081166836635451392/vSiBXHju_400x400.jpg",
    "name": "Estecool",
  },
  {
    "id": 2,
    "img":
        "https://www.dsm.com/personal-care/en_US/formulations/facial-skin-care/nourishing-barrier-skin-care-cream.thumb.800.480.png",
    "icon":
        "https://is5-ssl.mzstatic.com/image/thumb/Purple114/v4/f8/26/48/f8264838-4211-a3a0-693e-157bd9962202/source/256x256bb.jpg",
    "name": "Epilady",
  },
  {
    "id": 3,
    "img":
        "https://www.lynskincare.com/wp-content/uploads/2021/04/lyn-skincare-senin-en-iyi-halin.jpg",
    "icon":
        "https://pbs.twimg.com/profile_images/1081166836635451392/vSiBXHju_400x400.jpg",
    "name": "Estecool",
  },
  {
    "id": 4,
    "img":
        "https://letspepapp.com/wp-content/uploads/2021/01/Skin-Center-of-South-Miami-Facials-and-Skin-Care.jpg",
    "icon":
        "https://is5-ssl.mzstatic.com/image/thumb/Purple114/v4/f8/26/48/f8264838-4211-a3a0-693e-157bd9962202/source/256x256bb.jpg",
    "name": "Epilady",
  },
  {
    "id": 5,
    "img":
        "https://klinegroup.com/wp-content/uploads/2018/06/applying-professional-skin-care-serum.jpg",
    "icon":
        "https://pbs.twimg.com/profile_images/1081166836635451392/vSiBXHju_400x400.jpg",
    "name": "Estecool",
  },
];

const carouselImage = [
  "https://ankaramoonlight.com/wp-content/uploads/2017/05/hydrafacial-moonlight.jpg",
  "https://firsat.me/img/big1024/13915_58bd7db143d63_980x400.png",
  "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/flawlessskin-1589384044.png"
];
