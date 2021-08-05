import 'package:ev_mobil/screens/homeDetailPage.dart';
import 'package:ev_mobil/widgets/homeContainerWidget.dart';
import 'package:ev_mobil/widgets/storyWidget.dart';
import 'package:flutter/material.dart';

import '../settings/consts.dart';

class HomePage extends StatefulWidget {
  static const route = "/homePage";
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController teSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
      List<Widget> homeList = [
      HomeContainerWidget(
       iconNumber: 0,
       imgNumber: 0,
       cardText: "Kendin için bir\nşeyler yap...",
       onPressed: () {
          // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
         Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeDetailPage()));
       },
     ),
     HomeContainerWidget(
       iconNumber: 1,
       imgNumber: 2,
       cardText: "",
       onPressed: () {
         // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
         Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeDetailPage()));
       },
     ),
    ];

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              //-----------------------------Header-------------------------------
              // Bir arama Textfield'ı içerir
              Padding(
                padding: const EdgeInsets.only(left: maxSpace, right: maxSpace),
                child: TextField(
                  controller: teSearch, //search TextEditingControllerı
                  cursorColor: primaryColor, // cursorColor: odaklanan imleç rengi
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      color: primaryColor,
                      size: 35,
                    ),
                    hintText: "Estetik Vitrini",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: primaryColor, fontFamily: leadingFont),
                    focusColor: primaryColor,
                    hoverColor: primaryColor,
                    //border textField'ı çevreleyen yapı
                    //width:0 ve none verilerek kaldırıldı
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              //------------------------------------------------------------------

              //----------------Story Paneli---------------
              //StoryWidget kullanıldı
              Flexible(
                flex: 1,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: 
                    [Row(
                      children: [
                        StoryWidget(
                          iconNumber: 0,
                          imgNumber: 0,
                          nameNumber: 0,
                        ),
                        StoryWidget(
                          iconNumber: 1,
                          imgNumber: 1,
                          nameNumber: 1,
                        ),
                        StoryWidget(
                          iconNumber: 2,
                          imgNumber: 2,
                          nameNumber: 2,
                        ),
                        StoryWidget(
                          iconNumber: 3,
                          imgNumber: 3,
                          nameNumber: 3,
                        ),
                        StoryWidget(
                          iconNumber: 2,
                          imgNumber: 2,
                          nameNumber: 2,
                        ),
                        SizedBox(width: defaultPadding), //Son storynin kırpılasını önler
                      ],
                    ),
                  ],
                ),
              ),
              //-------------------------------------------
              SizedBox(height: defaultPadding), //Storyler - Postlar arası boşluk
              //------------------------------------Anasayfa Postları----------------------------------------
              //HomeContainerWidget ile oluşturuldu
              Flexible(
                flex: 4,
                child: ListView.builder(
                  itemCount: homeList.length,
                  itemBuilder: (BuildContext context, int index){
                  return homeList[index];
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
