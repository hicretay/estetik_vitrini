import 'package:flutter/material.dart';

import '../settings/consts.dart';

class StoryWidget extends StatelessWidget {
  //homePage sayfasında story görünümü oluşturulmasında kullanıldı
  final int
      imgNumber; //stories listesinden indexe göre alınacak resim(arkada kalan)
  final int iconNumber; //alınacak icon
  final int nameNumber; //story adı

  const StoryWidget({Key key, this.imgNumber, this.iconNumber, this.nameNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          // widgetların birbirine göre konumlandırılmasını sağlar
          clipBehavior: Clip
              .none, //clip.none: üstte kalan widgetın kırpılmasını önler,taşmasını gösterir
          children: [
            //---------Arkada kalan  elips görünümlü resim containerı-----------
            Container(
              height: 100,
              width: 75,
              decoration: BoxDecoration(
                // kenar yuvarlatma
                borderRadius: BorderRadius.circular(70),
                image: DecorationImage(
                  fit: BoxFit.cover, // resim containerı kaplasın
                  image: NetworkImage(
                    stories[imgNumber]["img"], //image indexi
                  ),
                ),
              ),
            ),
            //------------------------------------------------------------------
            Positioned(
              //Elips şekilli container ile chid'ına verilen containerı konumlandırır
              top: 20,
              left: 40,
              //----------------Circle story container'ı----------------
              child: Container(
                //Genişlik - yükseklik eşit verilip shape circle verilerek şekillendirildi
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    //storyColor ile mor - beyaz renkleri liste haline getirildi,
                    //gradient ile center olarak konumlandırılıp dış çerçeve oluşturuldu
                    colors: storyColor,
                    begin: Alignment.center,
                    end: Alignment.center,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                      2.0), // mor rengin genişliğini ayaralar
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: lightWhite,
                        width: 2.0, // beyaz rengin genişliğini ayarlar
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          stories[iconNumber]["icon"],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //-----------------------------------------------------
            ),
          ],
        ),
        SizedBox(
            height: minSpace), //story resmi - story adı arası boşluğu sağlar
        Text(
          stories[nameNumber]["name"], // Story nin ait olduğu firma adı
        ),
        SizedBox(width: 110), //storyler arası boşluğu sağlar
      ],
    );
  }
}
