import 'package:estetikvitrini/screens/googleMapPage.dart';
import 'package:estetikvitrini/screens/makeAppointmentCalendarPage.dart';
import 'package:estetikvitrini/settings/appointmentObject.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/leadingRowWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:line_icons/line_icons.dart';

class HomeDetailPage extends StatefulWidget {
  final List homeDetailContent;
  final List homeContent;
  HomeDetailPage({Key key, this.homeDetailContent, this.homeContent}) : super(key: key);

  @override
  _HomeDetailPageState createState() => _HomeDetailPageState(homeDetailContent: homeDetailContent, homeContent: homeContent);
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  List homeDetailContent;
  List homeContent;

  bool _checked = false;
  int counter = 99;
  
  _HomeDetailPageState({this.homeDetailContent, this.homeContent});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: Builder(builder: (context)=>
              BackGroundContainer(
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
                          child: Text(homeContent[0].companyName,
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
                      child: ListView.builder(
                        itemCount: homeDetailContent.length,
                        itemBuilder: (BuildContext context, int index){                      
                        _checked = homeContent[index].liked; // Gönderi beğenilmiş mi servisten okuyacak                  
                        return Column(
                            children: [
                              SizedBox(height: maxSpace),
                              LeadingRowWidget( 
                                companyName: homeContent[index].companyName,
                                companyLogo: homeContent[index].companyLogo,
                                pinColor: Colors.transparent,),//leading widgetı
                              Padding(padding: const EdgeInsets.only(right: defaultPadding,left: defaultPadding, bottom: defaultPadding),
                                child: Center(
                                  //-----------------------Carousel Containerı------------------------
                                    child: Container(
                                    width: double.infinity, //genişlik: container genişliği
                                    height: 250, //container yüksekliği: 250
                                    decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(maxSpace), //Resmin kenarlarının yuvarlatılması
                                    image: DecorationImage(
                                    fit: BoxFit.cover, // Resim containerı kaplasın
                                    image: NetworkImage(
                                      homeDetailContent[index].contentPictures[0].cPicture
                                    ),
                                  ),
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
                                          onPressed: () {
                                          }),
                              //------------------------------------------------------------------------
                               //----------------------Konum iconButton'ı-------------------------------
                                      IconButton(icon: Icon(LineIcons.locationArrow,
                                            color: primaryColor,
                                            size : iconSize,
                                          ),
                                          onPressed: () async{
                                            final progressUHD = ProgressHUD.of(context);
                                            progressUHD.show();
                                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>GoogleMapPage(locationUrl: homeContent[index].googleAdressLink)));
                                            progressUHD.dismiss(); 
                                          }),
                              //------------------------------------------------------------------------
                                    ],
                                  ),
                                  
                                //-------------------------RANDEVU AL BUTONU----------------------------
                                Material(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(30.0),
                                child: MaterialButton(
                                  minWidth: deviceWidth(context) * 0.4, //Buton minimum genişliği
                                  onPressed: () {
                                    setState(() {
                                      AppointmentObject appointment = AppointmentObject(companyId: homeContent[index].companyId,userId: 1);
                                      final progressHUD = ProgressHUD.of(context);
                                      progressHUD.show(); 
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => MakeAppointmentCalendarPage(companyInfo: homeContent, appointment: appointment)));
                                      progressHUD.dismiss();
                                    });
                                    //Buton tıklandığında randevu al sayfasına yönlendirilecek
                                  },
                                  child: Row(
                                    children: [
                                      //----------------------------Buton Metni------------------------------------------
                                      Text("Randevu Al",style: Theme.of(context).textTheme.button.copyWith(color: white)),
                                      //---------------------------------------------------------------------------------
                                      SizedBox(width: 10), //butondaki Text ve icon arası boşluk
                                      Icon(LineIcons.arrowRight,color: lightWhite),
                                    ],
                                  ),
                                ),
                              )
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
                                    Text("${homeDetailContent[index].likeCount} kişi tarafından favorilere eklendi"),
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
                                      child    : Text(homeContent[index].contentTitle.toString(),
                                      style    : TextStyle(fontSize: 22, color: primaryColor),
                                      ),
                                    ),
                                    Text(homeDetailContent[index].campaingDetail),
                                  ],
                                ),
                              ),
                              //------------------------------------------------------
                            ],
                          );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
//--------------------------------Carousel fonksiyonu------------------------------------
//   Carousel buildCarousel() {
//     return Carousel(
//       borderRadius: true,
//       radius: Radius.circular(maxSpace),
//       boxFit: BoxFit.cover,
//       autoplay: false,
//       animationCurve: Curves.bounceInOut, // animasyon efekti
//       animationDuration: Duration(milliseconds: 1000), // animasyon süresi
//       dotSize: 6.0, //Nokta büyüklüğü
//       dotIncreasedColor: primaryColor, // Seçili sayfa noktası rengi
//       dotBgColor: Colors.transparent, //Carousel alt bar rengi
//       dotPosition: DotPosition.bottomCenter, // Noktaların konumu
//       dotVerticalPadding: 10.0, //noktaların dikey uzaklığı
//       showIndicator: true, // sayfa geçişi noktaları gösterilsin mi = true
//       indicatorBgPadding: 7.0, // noktaların Carousel zemininden uzaklığı
//       images: [
//         //Carousel resimleri dizisi
//         NetworkImage(carouselImage[0]),
//         NetworkImage(carouselImage[1]),
//         NetworkImage(carouselImage[2]),
//       ],
//     );
//   }
}