import 'package:carousel_pro/carousel_pro.dart';
import 'package:estetikvitrini/screens/makeAppointmentCalendarPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/homeContainerWidget.dart';
import 'package:estetikvitrini/screens/homeDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

class FavoritePage extends StatefulWidget {
  static const route = "/favoritePage";

  FavoritePage({Key key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  TextEditingController teSearch = TextEditingController();
  int counter = 99;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BackGroundContainer(
          colors: backGroundColor1,
          child: Column(        
            children: [
              //-----------------------Sayfa Başlığı----------------------------
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 20),
                child: Align(
                  alignment: Alignment.topLeft, // başlık sola bitişik
                  child: Text(
                    "Favori\nSalonlar",
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: white, fontFamily: leadingFont),
                  ),
                ),
              ),
              //----------------------------------------------------------------
              //------------------------- // Arkaplan containerı------------------
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(cardCurved)),//Yalnızca dikeyde yuvarlatılmış
                  ),
                  child: ListView.builder(
                    itemCount: 1,
                    controller: NavigationProvider.of(context)
                    .screens[FAVORITE_PAGE]
                    .scrollController,
                    itemBuilder: (BuildContext context, int index){
                      return Column(children:[
                        HomeContainerWidget(
                          iconNumber: 0,
                          imgNumber: 1,
                          cardText: "",
                          child: IconButton(
                             // pin butonu
                             icon: Icon(FontAwesomeIcons.thumbtack,color: primaryColor,size: 20),
                             onPressed: (){}, // olayı parametre alındı
                           ),
                          onPressed: () {
                             // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeDetailPage()));
                          },
                         ),
                         HomeContainerWidget(
                          iconNumber: 1,
                          imgNumber: 2,
                          cardText: "Kendin için bir\nşeyler yap...",
                          child: IconButton(
                             // pin butonu
                             icon: Icon(FontAwesomeIcons.thumbtack,color: primaryColor,size: 20),
                             onPressed: (){}, // olayı parametre alındı
                           ),
                          onPressed: () {
                             // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeDetailPage()));
                          },
                         ),
                        ],
                      );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
//-----------------------------MaterialButton fonksiyonu-----------------------------------
  Material buildReservationButton() {
    return Material(
      color: primaryColor,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        minWidth: deviceWidth(context) * 0.4, //Buton minimum genişliği
        onPressed: () {
          setState(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MakeAppointmentPage()));
          });
          //Buton tıklandığında randevu al sayfasına yönlendirilecek
        },
        child: Row(
          children: [
            //-------------Buton Metni-------------
            Text(
              "Randevu Al",
              style: Theme.of(context).textTheme.button.copyWith(color: white),
            ),
            //-------------------------------------
            SizedBox(width: 10), //butondaki Text ve icon arası boşluk
            Icon(
              LineIcons.arrowRight, //ileri iconu
              color: lightWhite,
            ),
          ],
        ),
      ),
    );
  }
//---------------------------------------------------------------------------------------
//--------------------------------Carousel fonksiyonu------------------------------------
  Carousel buildCarousel() {
    return Carousel(
      borderRadius: true,
      radius: Radius.circular(maxSpace),
      boxFit: BoxFit.cover,
      autoplay: false,
      animationCurve: Curves.bounceInOut, // animasyon efekti
      animationDuration: Duration(milliseconds: 1000), // animasyon süresi
      dotSize: 6.0, //Nokta büyüklüğü
      dotIncreasedColor: primaryColor, // Seçili sayfa noktası rengi
      dotBgColor: Colors.transparent, //Carousel alt bar rengi
      dotPosition: DotPosition.bottomCenter, // Noktaların konumu
      dotVerticalPadding: 10.0, //noktaların dikey uzaklığı
      showIndicator: true, // sayfa geçişi noktaları gösterilsin mi = true
      indicatorBgPadding: 7.0, // noktaların Carousel zemininden uzaklığı
      images: [
        //Carousel resimleri dizisi
        NetworkImage(carouselImage[0]),
        NetworkImage(carouselImage[1]),
        NetworkImage(carouselImage[2]),
      ],
    );
  }
//--------------------------------------------------------------------------------------
}
