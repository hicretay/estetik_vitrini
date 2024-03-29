import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:estetikvitrini/JsnClass/companyProfile.dart';
import 'package:estetikvitrini/JsnClass/contentStreamDetailJsn.dart';
import 'package:estetikvitrini/JsnClass/likeJsn.dart';
import 'package:estetikvitrini/screens/companyProfilePage.dart';
import 'package:estetikvitrini/widgets/webViewWidget.dart';
import 'package:estetikvitrini/screens/makeAppointmentCalendarPage.dart';
import 'package:estetikvitrini/model/appointmentModel.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/backleadingWidget.dart';
import 'package:estetikvitrini/widgets/leadingRowWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';

class HomeDetailPage extends StatefulWidget {
  final List? homeDetailContent;
  final int? campaingId;
  final int? companyId;
  final String? companyLogo;
  final String? companyName;
  final String? contentTitle;
  final String? googleAdressLink;
  final String? companyPhone;
  HomeDetailPage({Key? key, this.homeDetailContent, this.campaingId, this.companyId, this.companyLogo, this.companyName, this.contentTitle, this.googleAdressLink, this.companyPhone}) : super(key: key);

  @override
  _HomeDetailPageState createState() => _HomeDetailPageState(homeDetailContent: homeDetailContent, 
  campaingId: campaingId, companyId: companyId, companyLogo: companyLogo, companyName: companyName, contentTitle: contentTitle, googleAdressLink: googleAdressLink, companyPhone: companyPhone);
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  List? homeDetailContent;
  int? campaingId;
  int? companyId ;
  String? companyLogo;
  String? companyName;
  String? contentTitle;
  String? googleAdressLink;
  String? companyPhone;

 late int userIdData;

  
  _HomeDetailPageState({this.homeDetailContent, this.campaingId, this.companyId, this.companyLogo, this.companyName, this.contentTitle, this.googleAdressLink, this.companyPhone});
  Future homeDetailRefresh() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     userIdData = prefs.getInt("userIdData")!; 
   final ContentStreamDetailJsn? detailNewList = await contentStreamDetailJsnFunc(companyId!,campaingId!,userIdData); 
   if (!mounted)
   return; 
   setState(() {
      homeDetailContent = detailNewList!.result;
   });
   }

  @override
  Widget build(BuildContext context) {
    final transformationController = TransformationController();
    //--------------------Slider Imageları-------------------
    List<dynamic> sliderImg = [];
    for (var item in homeDetailContent!.first.contentPictures) {
      //final transformationController = TransformationController();
      sliderImg.add(
        AspectRatio(
          aspectRatio: 16/9,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: NetworkImage(item.cPicture)),
              borderRadius: BorderRadius.all(Radius.circular(maxSpace))),),
        )
      );
    }   
    //-------------------------------------------------------                 

    return SafeArea(
        child: Scaffold(
        body: ProgressHUD(
        child: Builder(builder: (context)=>
              BackGroundContainer(
              child: Column(
              children: [
                BackLeadingWidget(
                  backColor: primaryColor,
                ),
                  Padding(padding: const EdgeInsets.only(left: maxSpace),
                      child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("kampanyalar", //Büyük Başlık
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: white, fontFamily: leadingFont),
                            ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(companyName!,  
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
                        color: passivePurple,//Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(cardCurved)),//Yalnızca dikeyde yuvarlatılmış
                      ),
                      child: FutureBuilder<dynamic>(
                        future: homeDetailRefresh(),
                        builder: (context, snapshot) {
                          return SingleChildScrollView(
                                 child: Column(
                                  children: [
                                    SizedBox(height: maxSpace),
                                    LeadingRowWidget( 
                                      companyName: companyName!,  
                                      companyLogo: companyLogo!,  
                                      leadingColor: Theme.of(context).hintColor,
                                      starButton: Container(),
                                      logoOnTap: ()async{
                                      final progressUHD = ProgressHUD.of(context);
                                      progressUHD!.show(); 
                                      final CompanyProfileJsn? companyProfile = await companyListDetailJsnFunc(companyId!);
                                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> CompanyProfilePage(companyProfile: companyProfile)));
                                      progressUHD.dismiss();
                                    },),//leading widgetı
                                    Padding(padding: const EdgeInsets.only(right: maxSpace,left: maxSpace, bottom: maxSpace,top: maxSpace/2),
                                      child: Center(
                                        //-----------------------Carousel Containerı------------------------
                                          child: Container(
                                          width: double.infinity, //genişlik: container genişliği
                                          height: deviceHeight(context)*0.3, //container yüksekliği
                                          child: homeDetailContent == null ? circularBasic : // ana sayfa içeriği boş ise circular, ekli görsel sayısı 1 ise Image.network
                                          sliderImg.length == 1 ? InteractiveViewer(
                                            panEnabled: false,
                                            clipBehavior: Clip.none,
                                            transformationController: transformationController,
                                            onInteractionEnd: (details){
                                              setState(() {
                                                transformationController.toScene(Offset.zero);
                                              });
                                            },
                                            child: AspectRatio(
                                              aspectRatio: 16/9,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(maxSpace)),
                                                  image: DecorationImage(
                                                  fit: BoxFit.fitWidth,
                                                  image: NetworkImage(homeDetailContent!.first.contentPictures.first.cPicture))),
                                                ),
                                            )): //  ekli görsel sayısı 1den fazla ise carousel 
                                          InteractiveViewer(
                                            panEnabled: false,
                                            clipBehavior: Clip.none,
                                            transformationController: transformationController,
                                            onInteractionEnd: (details){
                                              setState(() {
                                                transformationController.toScene(Offset.zero);
                                              });
                                            },
                                            child: Carousel(
                                            borderRadius: true,
                                            radius: Radius.circular(maxSpace),
                                            boxFit: BoxFit.fitWidth,
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
                                            images: sliderImg),
                                          )
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
                                          //-----------------------Beğeni iconButton'ı----------------------------
                                              child: CircleAvatar(//Beğeni butonunu kaplayan circleAvatar yapısı                                        
                                                maxRadius      : deviceWidth(context)*0.05,
                                                backgroundColor: homeDetailContent!.first.liked ? primaryColor : passivePurple, // seçili ise koyu, değilse açık renk verildi
                                                child: 
                                                IconButton( icon: homeDetailContent!.first.liked ? Icon(LineIcons.heart, color: white) : Icon(LineIcons.heart, color: darkWhite),
                                                onPressed: () async{
                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                  userIdData = prefs.getInt("userIdData")!; 
                                                  if(userIdData != 0){
                                                  LikeJsn? likePostData = await likeJsnFunc(userIdData, campaingId!);
                                                  print(likePostData!.success);
                                                  print(likePostData.result);
                                                  await homeDetailRefresh();
                                                  }
                                                  else{
                                                    showNotMemberAlert(context);
                                                  }
                                                }),
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
                                                    color      : darkWhite,
                                                    size       : iconSize),
                                                    onPressed  : () async{  
                                                      dynamic number = companyPhone; // arama ekranına yönlendirme
                                                      launch("tel://$number");
                                                    }),
                                            ),
                                    //------------------------------------------------------------------------
                                     //----------------------Konum iconButton'ı-------------------------------
                                            Padding(
                                              padding: const EdgeInsets.all(minSpace),
                                              child: IconButton(
                                                    padding    : EdgeInsets.zero,
                                                    constraints: BoxConstraints(),
                                                    icon       : Icon(LineIcons.locationArrow,
                                                    color      : darkWhite,
                                                    size       : iconSize),
                                                    onPressed  : () async{
                                                    final progressUHD = ProgressHUD.of(context);
                                                    progressUHD!.show();
                                                    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>WebViewWidget(locationUrl: googleAdressLink!)));
                                                    progressUHD.dismiss(); 
                                                  }),
                                            ),
                                    //------------------------------------------------------------------------
                                          ],
                                        ),
                                        
                                      //-------------------------RANDEVU AL BUTONU----------------------------
                                      homeDetailContent!.first.appointmentStatus == true ?
                                      Material(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: MaterialButton(
                                        minWidth: deviceWidth(context) * 0.4, //Buton minimum genişliği
                                        onPressed:
                                         () async{
                                           SharedPreferences prefs = await SharedPreferences.getInstance();
                                           userIdData = prefs.getInt("userIdData")!;  
                                           if(userIdData != 0){                            
                                            AppointmentObject appointment = AppointmentObject(companyId: companyId!,userId: userIdData, companyNameS: companyName!, campaignId: campaingId!);
                                            final progressHUD = ProgressHUD.of(context);
                                            progressHUD!.show(); 
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => MakeAppointmentCalendarPage(appointment: appointment)));
                                            progressHUD.dismiss();
                                    
                                          //Buton tıklandığında randevu al sayfasına yönlendirilecek
                                           }
                                           else{
                                              showNotMemberAlert(context);
                                           }
                                        } ,
                                        child: Row(
                                          children: [
                                            //----------------------------Buton Metni------------------------------------------
                                            Text("Randevu Al",style: Theme.of(context).textTheme.button!.copyWith(color: white)),
                                            //---------------------------------------------------------------------------------
                                            SizedBox(width: 10), //butondaki Text ve icon arası boşluk
                                            Icon(LineIcons.arrowRight,color: passivePurple),
                                          ],
                                        ),
                                      ),
                                    ): Container(
                                      width:  deviceWidth(context) * 0.4,
                                    ),
                                      ],
                                    ),
                                    SizedBox(height: maxSpace), // Alt Header ve beğeni metni arasındaki boşluk
                                    Padding(padding: const EdgeInsets.only(left: maxSpace),
                                      child: Row(
                                        children: [
                                          Icon(Icons.favorite, // Beğeni İcon'ı
                                          size : iconSize,
                                          color: darkWhite),
                                          SizedBox(width: minSpace),
                                          Text("${homeDetailContent!.first.likeCount} kişi tarafından beğenildi",style: TextStyle(color:darkWhite)),
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
                                            child    : Text(contentTitle!,
                                            style    : TextStyle(fontSize: 22, color: darkWhite),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Html(data: homeDetailContent!.first.campaingDetail)),//Text(homeDetailContent.first.campaingDetail, style: TextStyle(fontSize: 18, color: Theme.of(context).hintColor))),
                                        ],
                                      ),
                                    ),
                                    //------------------------------------------------------
                                  ],
                                ),
                             );
                        }
                      )
                     
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