import 'package:carousel_pro/carousel_pro.dart';
import 'package:estetikvitrini/screens/googleMapPage.dart';
import 'package:estetikvitrini/screens/makeAppointmentCalendarPage.dart';
import 'package:estetikvitrini/model/appointmentModel.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/leadingRowWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:line_icons/line_icons.dart';

class HomeDetailPage extends StatefulWidget {
  final List homeDetailContent;
  final List homeContent;
  final int indexx;
  HomeDetailPage({Key key, this.homeDetailContent, this.homeContent, this.indexx}) : super(key: key);

  @override
  _HomeDetailPageState createState() => _HomeDetailPageState(homeDetailContent: homeDetailContent, homeContent: homeContent, indexx: indexx);
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  List homeDetailContent;
  List homeContent;
  int indexx;

  bool _checked = false;
  int counter = 99;

  
  _HomeDetailPageState({this.homeDetailContent, this.homeContent, this.indexx});
  @override
  Widget build(BuildContext context) {
    print(indexx);
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
                          maxRadius: deviceWidth(context)*0.06,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            iconSize: iconSize,
                            icon: Icon(Icons.arrow_back,color: primaryColor,size: 23),
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
                  Padding(padding: const EdgeInsets.only(left: maxSpace),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Kampanyalar", //Büyük Başlık
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: white, fontFamily: leadingFont),
                            ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(homeContent[indexx-1].companyName,  /////////////////////düzeltilecek
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
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index){ 
                        //--------------------Slider Imageları-------------------
                        List<dynamic> sliderImg = [];
                        for (var item in homeDetailContent[index].contentPictures) {
                          sliderImg.add(NetworkImage(item.cPicture));
                        }   
                        //-------------------------------------------------------                 
                        _checked = homeContent[index].liked; // Gönderi beğenilmiş mi servisten okuyacak                  
                        return Column(
                            children: [
                              SizedBox(height: maxSpace),
                              LeadingRowWidget( 
                                companyName: homeContent[indexx-1].companyName,  /////////////////////düzeltilecek
                                companyLogo: homeContent[indexx-1].companyLogo,  /////////////////////düzeltilecek
                                pinColor: Colors.transparent,),//leading widgetı
                              Padding(padding: const EdgeInsets.only(right: maxSpace,left: maxSpace, bottom: maxSpace,top: maxSpace/2),
                                child: Center(
                                  //-----------------------Carousel Containerı------------------------
                                    child: Container(
                                    width: double.infinity, //genişlik: container genişliği
                                    height: deviceHeight(context)*0.3, //container yüksekliği
                                    child: homeDetailContent == null ? CircularProgressIndicator() :
                                    Carousel(
                                    borderRadius: true,
                                    radius: Radius.circular(maxSpace),
                                    boxFit: BoxFit.contain,
                                    autoplay: false,
                                    animationCurve: Curves.bounceInOut, // animasyon efekti
                                    animationDuration: Duration(milliseconds: 1000), // animasyon süresi
                                    dotSize: 6.0, //Nokta büyüklüğü
                                    dotIncreasedColor: primaryColor, // Seçili sayfa noktası rengi
                                    dotColor: secondaryColor,
                                    dotBgColor: Colors.transparent, //Carousel alt bar rengi
                                    dotPosition: DotPosition.bottomCenter, // Noktaların konumu
                                    dotVerticalPadding: 10.0, //noktaların dikey uzaklığı
                                    showIndicator: true, // sayfa geçişi noktaları gösterilsin mi = true
                                    indicatorBgPadding: 7.0, // noktaların Carousel zemininden uzaklığı                                   
                                    images: sliderImg)
                              ),
                            ),
                          ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  //-----------------Alt Header-----------------------
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(minSpace),
                                        child: CircleAvatar(//Beğeni butonunu kaplayan circleAvatar yapısı                                        
                                          maxRadius      : deviceWidth(context)*0.05,
                                          backgroundColor: _checked ? primaryColor : lightWhite, // seçili ise koyu, değilse açık renk verildi
                                          child          : IconButton(
                                          iconSize       : iconSize,
                                          icon           : Icon(LineIcons.heart,size: 18, color: _checked  ? Colors.white : primaryColor, //Seçili ise açık, değilse koyu renk verildi
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
                                      ),
                                      
                              // //-----------------------Paylaşım iconButton'ı----------------------------
                              //         Padding(
                              //           padding: const EdgeInsets.all(minSpace),
                              //           child: IconButton(
                              //                 padding    : EdgeInsets.zero,
                              //                 constraints: BoxConstraints(),
                              //                 icon       : Icon(Icons.share_outlined,
                              //                 color      : primaryColor,
                              //                 size       : iconSize),
                              //                 onPressed  : () {}),
                              //         ),
                              // //------------------------------------------------------------------------
                              //----------------------İletişim iconButton'ı-----------------------------
                                      Padding(
                                        padding: const EdgeInsets.all(minSpace),
                                        child: IconButton(
                                              padding    : EdgeInsets.zero,
                                              constraints: BoxConstraints(),
                                              icon       : Icon(LineIcons.phone,
                                              color      : primaryColor,
                                              size       : iconSize),
                                              onPressed  : () {}),
                                      ),
                              //------------------------------------------------------------------------
                               //----------------------Konum iconButton'ı-------------------------------
                                      Padding(
                                        padding: const EdgeInsets.all(minSpace),
                                        child: IconButton(
                                              padding    : EdgeInsets.zero,
                                              constraints: BoxConstraints(),
                                              icon       : Icon(LineIcons.locationArrow,
                                              color      : primaryColor,
                                              size       : iconSize),
                                              onPressed  : () async{
                                              final progressUHD = ProgressHUD.of(context);
                                              progressUHD.show();
                                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>GoogleMapPage(locationUrl: homeContent[index].googleAdressLink)));
                                              progressUHD.dismiss(); 
                                            }),
                                      ),
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
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => MakeAppointmentCalendarPage(companyInfo: homeContent, appointment: appointment, indexx: indexx)));
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
                              Padding(padding: const EdgeInsets.only(left: maxSpace),
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
                              Padding(padding: const EdgeInsets.all(maxSpace),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child    : Text(homeContent[indexx-1].contentTitle,
                                      style    : TextStyle(fontSize: 22, color: primaryColor),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(homeDetailContent[index].campaingDetail)),
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
}