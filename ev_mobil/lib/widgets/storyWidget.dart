import 'package:flutter/material.dart';

import '../settings/consts.dart';

class StoryWidget extends StatefulWidget {
  //homePage sayfasında story görünümü oluşturulmasında kullanıldı
  final int imgNumber; //stories listesinden indexe göre alınacak resim(arkada kalan)
  final int iconNumber; //alınacak icon
  final int nameNumber; //story adı

  const StoryWidget({Key key, this.imgNumber, this.iconNumber, this.nameNumber}) : super(key: key);

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //Genişlik - yükseklik eşit verilip shape circle verilerek şekillendirildi
          width: 82,
          height: 82,
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
          child: Padding(padding: const EdgeInsets.all(2.0), // mor rengin genişliğini ayaralar
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(
                  color: lightWhite,
                  width: 2.0, // beyaz rengin genişliğini ayarlar
                ),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(stories[widget.iconNumber]["icon"]),
                ),
              ),
            ),
          ),
        ),
        SizedBox( height: minSpace), //story resmi - story adı arası boşluğu sağlar
        Text( stories[widget.nameNumber]["name"]), // Story nin ait olduğu firma adı
        SizedBox(width: deviceWidth(context)*0.25), //storyler arası boşluğu sağlar
      ],
    );
  }
}
