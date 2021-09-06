import 'dart:async';
import 'package:estetikvitrini/JsnClass/companyListJsn.dart';
import 'package:estetikvitrini/JsnClass/contentStreamDetailJsn.dart';
import 'package:estetikvitrini/JsnClass/contentStreamJsn.dart';
import 'package:estetikvitrini/screens/googleMapPage.dart';
import 'package:estetikvitrini/screens/homeDetailPage.dart';
import 'package:estetikvitrini/screens/storyPage.dart';
import 'package:estetikvitrini/settings/connection.dart';
import 'package:estetikvitrini/widgets/homeContainerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  static const route = "/homePage";

  HomePage({Key key,}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  TextEditingController teSearch = TextEditingController();
  List homeContent; 
  List companyContent;

//---------------------------INTERNET KONTROLÜ STREAM'I------------------------------
  StreamSubscription _connectionChangeStream;
  bool isOffline = false;

  @override
  void initState() { 
    super.initState();
    homeContentList();
    companyStoryList();
    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
        _connectionChangeStream = connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
        isOffline = !hasConnection;
    });
}

   @override
   void dispose() {
     _connectionChangeStream.cancel();
     super.dispose();
   }

   Future homeContentList() async{
     final ContentStreamJsn homeContentNewList = await contentStreamJsnFunc(3); 
     setState(() {
        homeContent = homeContentNewList.result;
     });
   }

  Future companyStoryList() async{
   final CompanyListJsn companyNewList = await companyListJsnFunc(); 
   setState(() {
      companyContent = companyNewList.result;
   });
   }
//-------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
        body: ProgressHUD(
        child: (homeContent != null && companyContent != null) ? Builder(builder: (context)=>       
              Container(
              color: Colors.white,
              child: Stack(
              children: [
                  //-----------------------------BAŞLIK-------------------------------
                  Padding(
                    padding: const EdgeInsets.only(left: maxSpace, right: maxSpace),
                    child: TextField(
                      controller: teSearch, //search TextEditingControllerı
                      cursorColor: primaryColor, // cursorColor: odaklanan imleç rengi
                      decoration: InputDecoration(
                        suffixIcon: FaIcon(FontAwesomeIcons.search,color: primaryColor,size: 30,textDirection: TextDirection.ltr),                    
                        hintText: "Estetik Vitrini",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline4
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
                  //---------------------------Story Paneli---------------------------
                  Padding(
                    padding: EdgeInsets.only(left: maxSpace, right: maxSpace, top: 58),
                    child: RefreshIndicator(
                      backgroundColor: secondaryColor,
                      color: primaryColor,
                      onRefresh: ()=> companyStoryList(),
                      child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: companyContent.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: maxSpace);
                      },                   
                      itemBuilder: (BuildContext context,index){
                        return Column(children:[
                            GestureDetector(
                            child:  Stack(children:[
                          Container(
                            width: deviceWidth(context)*0.2,
                            height: deviceWidth(context)*0.2,
                            decoration: BoxDecoration(
                            border: Border.all(
                            color: darkWhite,
                            width: 3),
                            shape: BoxShape.circle),
                            child: Container(
                            width: deviceWidth(context)*0.21,
                            height: deviceWidth(context)*0.21,
                            decoration: BoxDecoration(
                            border: Border.all(
                            color: secondaryColor,
                            width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(companyContent[index].companyLogo),
                                  ),
                                ),
                              ),
                          ),
                        ]),
                        //------------------------------------------------STORYE TIKLANDIĞINDA----------------------------------------------------------
                        onTap: ()async{
                            final progressHUD = ProgressHUD.of(context);
                            progressHUD.show();
                            print(index);
                            // StoryContentJsn storyContent = await storyContentJsnFunc(companyContent[index].id);
                            Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(builder: (context)=>StoryPage(company: companyContent, storyIndex: index)));
                            progressHUD.dismiss();
                        },
                        //------------------------------------------------------------------------------------------------------------------------------
                        ),
                        SizedBox(
                          width: 55.0,
                          child: Center(
                            child: Text(companyContent[index].companyName,              
                            overflow: TextOverflow.fade,
                            softWrap: false),
                          ),
                        ),
                      ],
                        );
                        
                      }),
                    ),
                  ),
                  //--------------------------------------------------------------------------------------------
                  //------------------------------------Anasayfa Postları----------------------------------------
                  Padding(
                    padding: EdgeInsets.only(top:58+deviceWidth(context)*0.2+20),
                    child: RefreshIndicator(
                      backgroundColor: secondaryColor,
                      color: primaryColor,
                      onRefresh: ()async{
                        await showToast(context, "Akış yenilendi !");
                        return homeContentList();
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:  homeContent == null ? 0 : homeContent.length,
                        itemBuilder: (BuildContext context, int index){
                        return HomeContainerWidget(
                          companyLogo   : homeContent[index].companyLogo,
                          companyName   : homeContent[index].companyName,
                          contentPicture: homeContent[index].contentPicture,
                          cardText      : homeContent[index].contentTitle,
                          pinColor      : primaryColor,
                          liked         : homeContent[index].liked,
                          onPressedPhone: () async{ 
                                          dynamic number = homeContent[index].companyPhone.toString();
                                          //bool res = await FlutterPhoneDirectCaller.callNumber(number);
                                          launch("tel://$number");
                                        },
                          //--------------------------------------------------------"DETAYLI BİLGİ İÇİN" BUTONU-------------------------------------------------------------
                          onPressed: () async{
                          final progressUHD = ProgressHUD.of(context);
                          progressUHD.show(); 
                          final ContentStreamDetailJsn homeDetailContent = await contentStreamDetailJsnFunc(homeContent[index].companyId, homeContent[index].campaingId);                        
                          // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeDetailPage(homeDetailContent: homeDetailContent.result,homeContent: homeContent,indexx: homeContent[index].campaingId)));
                          progressUHD.dismiss();
                        },
                        //---------------------------------------------------------------------------------------------------------------------------------------------------
                        //-----------------------------------------------------------KONUM ICONBUTTON'I----------------------------------------------------------------------
                        onPressedLocation: (){
                          final progressUHD = ProgressHUD.of(context);
                          progressUHD.show();
                          int indeks = homeContent[index].companyId;
                          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>GoogleMapPage(locationUrl: homeContent[indeks-1].googleAdressLink))); 
                          progressUHD.dismiss();
                        },
                        //-----------------------------------------------------------------------------------------------------------------------------------------------------
                      );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ) : circularBasic
        ),
      ),
    );
  }
}
