import 'package:carousel_pro/carousel_pro.dart';
import 'package:ev_mobil/screens/makeAppointmentCalendarPage.dart';
import 'package:ev_mobil/settings/consts.dart';
import 'package:ev_mobil/widgets/backgroundContainer.dart';
import 'package:ev_mobil/widgets/leadingRowWidget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class HomeDetailPage extends StatefulWidget {
  HomeDetailPage({Key key}) : super(key: key);

  @override
  _HomeDetailPageState createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  bool _checked = false;
  int counter = 99;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BackGroundContainer(
          colors: backGroundColor1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  children: [
                    CircleAvatar(
                      //iconun çevresini saran yapı tasarımı
                      maxRadius: 25,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        iconSize: iconSize,
                        icon: Icon(Icons.arrow_back,color: primaryColor,size: 25),
                        onPressed: (){Navigator.pop(context, false);},
                      ),
                    ),
                    SizedBox(width: maxSpace),
                    Text("Estetik Vitrini",
                      style     : TextStyle(
                      fontFamily: leadingFont, fontSize: 25, color: Colors.white),
                    ),
                  ],
                )
              ),
              Padding(padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Kampanyalar",
                        style: TextStyle(
                          fontFamily: leadingFont,
                          color: Colors.white,
                          fontSize: 45,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Estecool Güzellik Merkezi",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: maxSpace)
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                    color: lightWhite,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(cardCurved)),//Yalnızca dikeyde yuvarlatılmış
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                        children: [
                          SizedBox(height: maxSpace),
                          LeadingRowWidget( 
                            iconNumber: 0,
                            pinColor: Colors.transparent,),//leading widgetı
                          Padding(padding: const EdgeInsets.all(20.0),
                            child: Center(
                              //-----------------------Carousel Containerı------------------------
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(maxSpace)),
                                  child : SizedBox(
                                  width : double.infinity, //genişlik: container kadar
                                  height: deviceHeight(context) * 0.25,//yükseklik
                                  child : buildCarousel(), //Carousel fonksiyonu
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //-----------------Alt Header-----------------------
                              Row(
                                children: [
                                  CircleAvatar(
                                    //Beğeni butonunu kaplayan circleAvatar yapısı
                                    maxRadius: 22.5,
                                    backgroundColor: _checked ? primaryColor : lightWhite, // seçili ise koyu, değilse açık renk verildi
                                    child: IconButton(
                                      iconSize: iconSize,
                                      icon: Icon(LineIcons.heart, color: _checked  ? Colors.white : primaryColor, // //Seçili ise açık, değilse koyu renk verildi
                                      ),
                                      onPressed: () {
                                        setState(() { 
                                          _checked = !_checked; //tıklandığında bool değeri tersler
                                          _checked ? counter++ : counter--; // seçili ise sayaç bir artar, seçim kaldırılırsa azalır
                                          },
                                        );
                                      },
                                    ),
                                  ),
                          //-----------------------Paylaşım iconButton'ı----------------------------
                                  IconButton(icon: Icon(Icons.share_outlined,
                                        color: primaryColor,
                                        size : iconSize,
                                      ),
                                      onPressed: () {}),
                          //------------------------------------------------------------------------
                          //----------------------İletişim iconButton'ı-----------------------------
                                  IconButton(icon: Icon(LineIcons.phone,
                                        color: primaryColor,
                                        size : iconSize,
                                      ),
                                      onPressed: () {}),
                          //------------------------------------------------------------------------
                           //----------------------Konum iconButton'ı-------------------------------
                                  IconButton(icon: Icon(LineIcons.locationArrow,
                                        color: primaryColor,
                                        size : iconSize,
                                      ),
                                      onPressed: () {}),
                          //------------------------------------------------------------------------
                                ],
                              ),
                              buildReservationButton(), //Rezervasyon MaterialButton'ı
                            ],
                          ),
                          SizedBox(height: maxSpace), // Alt Header ve beğeni metni arasındaki boşluk
                          Padding(padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Icon(Icons.favorite, // Beğeni İcon'ı
                                size : iconSize,
                                color: primaryColor),
                                SizedBox(width: minSpace),
                                Text("$counter kişi tarafından favorilere eklendi"),
                                // counter ile gösterilecek beğeni sayısı
                              ],
                            ),
                          ),
                          //------------------Açıklama Metni----------------------
                          Padding(padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child    : Text("Kendin için bir şey yap.",
                                  style    : TextStyle(fontSize: 22, color: primaryColor),
                                  ),
                                ),
                                Text(aboutText),
                              ],
                            ),
                          ),
                          //------------------------------------------------------
                        ],
                      ),
                  ),
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
}