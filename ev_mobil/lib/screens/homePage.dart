import 'package:ev_mobil/settings/navigationProvider.dart';
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
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            //-------------------Header----------------------
            // Bir arama Textfield'ı içerir
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                  hintStyle: TextStyle(
                      color: primaryColor,
                      fontFamily: leadingFont,
                      fontSize: 35),
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
            //------------------------------------------------

            //----------------Story Paneli---------------
            //StoryWidget kullanıldı
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
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
                ],
              ),
            ),
            //-------------------------------------------

            //------------------------------------Anasayfa Postları----------------------------------------
            //HomeContainerWidget ile oluşturuldu
            Flexible(
              child: ListView(
                children: [
                  Column(
                    children: [
                      HomeContainerWidget(
                          iconNumber: 0,
                          imgNumber: 0,
                          cardText: "Kendin için bir\nşeyler yap...",
                          onPressed: () {
                            //"Detaylı Bilgi İçin" butouna basıldığında Favori Salonlara yönlendirecek
                            NavigationProvider.of(context)
                                .setTab(FAVORITE_PAGE);
                          }),

                      HomeContainerWidget(
                        iconNumber: 1,
                        imgNumber: 2,
                        cardText: "",
                        onPressed: () {
                          // "Detaylı Bilgi İçin" butouna basıldığında Favori Salonlara yönlendirecek
                          setState(() {
                            NavigationProvider.of(context)
                                .setTab(FAVORITE_PAGE);
                          });
                        },
                      ),
                      //HomeContainerWidget(),
                    ],
                  ),
                  //-------------------------------------------------------------------------------------------------
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
