import 'dart:async';
import 'package:estetikvitrini/JsnClass/companyListJsn.dart';
import 'package:estetikvitrini/JsnClass/contentStreamDetailJsn.dart';
import 'package:estetikvitrini/JsnClass/contentStreamJsn.dart';
import 'package:estetikvitrini/JsnClass/storyContentJsn.dart';
import 'package:estetikvitrini/screens/googleMapPage.dart';
import 'package:estetikvitrini/screens/homeDetailPage.dart';
import 'package:estetikvitrini/screens/storyPage.dart';
import 'package:estetikvitrini/settings/connection.dart';
import 'package:estetikvitrini/widgets/homeContainerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
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

  _HomePageState({this.cityDenemeID});
  int cityDenemeID ;

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
                    child: Padding(
                    padding: const EdgeInsets.only(right: defaultPadding,top: defaultPadding),
                    child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Estetik Vitrini", 
                    style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: primaryColor, fontFamily: leadingFont)),
                      ),
                    ),
                  ),
                  //------------------------------------------------------------------
                  //---------------------------Story Paneli---------------------------
                  Padding(
                    padding: EdgeInsets.only(left: maxSpace, right: maxSpace, top: 48),
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
                          final StoryContentJsn storyContent = await storyContentJsnFunc(companyContent[index].id);
                          Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(builder: (context)=>StoryPage(company: companyContent, storyContent: storyContent)));
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
                  //--------------------------------------------------------------------------------------------
                  //------------------------------------Anasayfa Postları----------------------------------------
                  Padding(
                    padding: EdgeInsets.only(top:48+deviceWidth(context)*0.2+20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:  homeContent == null ? 0 : homeContent.length,
                      itemBuilder: (BuildContext context, int index){
                      return HomeContainerWidget(
                        companyLogo   : homeContent[index].companyLogo,
                        companyName   : homeContent[index].companyName,
                        companyPhone  : homeContent[index].companyPhone,
                        contentPicture: homeContent[index].contentPicture,
                        cardText      : homeContent[index].contentTitle,
                        pinColor      : primaryColor,
                        //--------------------------------------------------------"DETAYLI BİLGİ İÇİN" BUTONU-------------------------------------------------------------
                        onPressed: () async{
                          
                          // setState(() {
                          //    globalHomeContentId = homeContent[index];             
                          // });
                        final progressUHD = ProgressHUD.of(context);
                        progressUHD.show(); 
                        final ContentStreamDetailJsn homeDetailContent = await contentStreamDetailJsnFunc(homeContent[index].companyId, homeContent[index].campaingId);                        
                        // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeDetailPage(homeDetailContent: homeDetailContent.result,homeContent: homeContent,indexx: homeContent[index].companyId)));
                        progressUHD.dismiss();
                      },
                      //---------------------------------------------------------------------------------------------------------------------------------------------------
                      //-----------------------------------------------------------KONUM ICONBUTTON'I----------------------------------------------------------------------
                      onPressedLocation: (){
                        final progressUHD = ProgressHUD.of(context);
                        progressUHD.show();
                        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>GoogleMapPage(locationUrl: homeContent[index].googleAdressLink)));
                        progressUHD.dismiss();
                      },
                      //-----------------------------------------------------------------------------------------------------------------------------------------------------
                    );
                    }),
                  )
                ],
              ),
            ),
          ):CircularProgressIndicator(),
        ),
      ),
    );

  }
}
