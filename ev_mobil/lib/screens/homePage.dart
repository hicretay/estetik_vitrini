import 'dart:async';
import 'package:estetikvitrini/JsnClass/companyListJsn.dart';
import 'package:estetikvitrini/JsnClass/companyProfile.dart';
import 'package:estetikvitrini/JsnClass/contentStreamDetailJsn.dart';
import 'package:estetikvitrini/JsnClass/contentStreamJsn.dart';
import 'package:estetikvitrini/JsnClass/likeJsn.dart';
import 'package:estetikvitrini/providers/themeDataProvider.dart';
import 'package:estetikvitrini/screens/companyProfilePage.dart';
import 'package:estetikvitrini/screens/searchPage.dart';
import 'package:estetikvitrini/widgets/webViewWidget.dart';
import 'package:estetikvitrini/screens/homeDetailPage.dart';
import 'package:estetikvitrini/settings/connection.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/homeContainerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  static const route = "/homePage";

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List homeContent = []; 
  int pageIndex = 1;
  int totalPage = 1;
  bool textFieldTapped = false;
  List companyContent;
  int userIdData;

//---------------------------INTERNET KONTROLÜ STREAM'I------------------------------
  StreamSubscription _connectionChangeStream;
  bool isOffline = false;
//-----------------------------------------
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  Future getHomeData(LoadStatus mode) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     userIdData = prefs.getInt("userIdData"); 
    if(mode == LoadStatus.idle){
      pageIndex = 1;
    }
    else{
      if(pageIndex > totalPage){
        refreshController.loadNoData();
        return false;
      }
    }

    final response = await http.post(
    Uri.parse(url + "ContentStream/List"),
    body: '{"userId":' + userIdData.toString() + ',' + '"page":' + pageIndex.toString() + '}',
    headers: header
  );

  if (response.statusCode == 200) {
    final result = contentStreamJsnFromJson(response.body);
    if(mode == LoadStatus.idle){
      homeContent = result.result;
    }
    else{
      homeContent.addAll(result.result);
      }
    pageIndex++;
    totalPage = result.totalPage;

    setState(() {});
    return true;
  } else {
    return false;
  }}
  @override
  void initState() { 
    super.initState();
     Provider.of<ThemeDataProvider>(context, listen: false).loadTheme();
    getHomeData(LoadStatus.loading);
    companyStoryList();
    setState(() {});
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

  Future companyStoryList() async{
   final CompanyListJsn companyNewList = await companyListJsnFunc(); 
   setState(() {
      companyContent = companyNewList.result;
   });
   }

   Future refreshContentStream() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     userIdData = prefs.getInt("userIdData");
   final ContentStreamJsn companyNewList = await contentStreamJsnFunc(userIdData,0); 
   setState(() {
      homeContent = companyNewList.result;
   });
   }
//-------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {  
    return  Container(
      color: Colors.transparent,
      child: SafeArea(     
        top: false, 
          child: Scaffold(
          body: ProgressHUD(
          child: (homeContent != null && companyContent != null) ? Builder(builder: (context)=>              
                BackGroundContainer(
                colors: Provider.of<ThemeDataProvider>(context, listen: true).isLightTheme ? backGroundColor1 : backGroundColorDark,
                child: Stack(
                children: [
                    //-----------------------------BAŞLIK-------------------------------
                    Padding(
                      padding: EdgeInsets.only(top: deviceHeight(context)*0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(width: deviceWidth(context)*0.6,height: deviceHeight(context)*0.04, child: SvgPicture.asset("assets/images/nameLogo.svg",color: white)),
                          GestureDetector(
                            child: FaIcon(FontAwesomeIcons.search,color: primaryColor,size: 25,textDirection: TextDirection.ltr),
                            onTap: (){
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>SearchPage()));
                            }
                            ),
                        ],
                      ),
                    ),
                    //------------------------------------------------------------------
                    //---------------------------Story Paneli---------------------------
                    Padding(
                      padding: EdgeInsets.only(left: maxSpace, right: maxSpace, top: 78),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: companyContent.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: maxSpace);},                   
                        itemBuilder: (BuildContext context,index){
                          return Column(children:[
                              GestureDetector(
                              child:  Stack(children:[
                            Container(                          
                              decoration: BoxDecoration(
                              color: white,
                              shape: BoxShape.circle),
                              child: Container(
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
                            ),
                          ]),
                          //------------------------------------------------STORYE TIKLANDIĞINDA----------------------------------------------------------
                          onTap: ()async{
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD.show();
                              //int lastCompId = companyContent.last.id;
                              // Navigator.of(context, rootNavigator: true).push(
                              // MaterialPageRoute(builder: (context)=>StoryPage(company: companyContent, storyIndex: index, lastCompId: lastCompId)));
                              final CompanyProfileJsn companyProfile = await companyListDetailJsnFunc(companyContent[index].id);
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> CompanyProfilePage(companyProfile: companyProfile)));
                              progressHUD.dismiss();
                          },
                          //------------------------------------------------------------------------------------------------------------------------------
                          ),
                          SizedBox(
                            width: 65.0,
                            child: Center(
                              child: Text(companyContent[index].companyName,              
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(color: white)),
                            ),
                          ),
                        ]);
                        }),
                    ),
                    //--------------------------------------------------------------------------------------------
                    //------------------------------------Anasayfa Postları----------------------------------------
                    Padding(
                      padding: EdgeInsets.only(top:78+deviceWidth(context)*0.2+20),
                      child: SmartRefresher(                     
                        controller: refreshController,
                        enablePullUp: true,
                        header: CustomHeader(
                          builder: (c,m)=> circularBasic,
                        ),
                        footer: CustomFooter(
                        builder: (BuildContext context,LoadStatus mode){
                          Widget body ;
                          if(mode==LoadStatus.idle){
                            body = circularBasic;
                          }
                          else if(mode==LoadStatus.loading){
                            body = circularBasic;
                          }
                          else if(mode == LoadStatus.failed){
                            body = Text("Hepsini gördün");
                          }
                          else if(mode == LoadStatus.canLoading){
                              body = circularBasic;
                          }
                          else if(mode == LoadStatus.noMore){
                             body = circularBasic;
                          }
                          else{
                            body = circularBasic;
                          }
                          return Container(
                            child: Center(child:body),
                          );
                        },
                      ),
                        onRefresh: ()async{
                          final result =await getHomeData(LoadStatus.noMore);
                          if(result){
                            refreshController.refreshCompleted();
                          }
                          else{
                            refreshController.refreshFailed();
                          }
                        },
                        
                        onLoading: ()async{
                           final result =await getHomeData(LoadStatus.loading);
                           if(result){
                             refreshController.loadComplete();
                           }
                           else{
                             refreshController.loadFailed();
                           }
                        },
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:  homeContent.length,
                            itemBuilder: (BuildContext context, int index){
                            return HomeContainerWidget(
                              companyLogo   : homeContent[index].companyLogo,
                              companyName   : homeContent[index].companyName,
                              contentPicture: homeContent[index].contentPicture,
                              cardText      : homeContent[index].contentTitle,
                              pinColor      : primaryColor,
                              onPressedPhone: () async{ 
                                              dynamic number = homeContent[index].companyPhone.toString(); // arama ekranına yönlendirme
                                              launch("tel://$number");
                                            },
                              //--------------------------------------------------------"DETAYLI BİLGİ İÇİN" BUTONU-------------------------------------------------------------
                              onPressed: () async{
                              final progressUHD = ProgressHUD.of(context);
                              progressUHD.show();
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              userIdData = prefs.getInt("userIdData"); 
                              final ContentStreamDetailJsn homeDetailContent = await contentStreamDetailJsnFunc(homeContent[index].companyId, homeContent[index].campaingId,userIdData);                        
                              // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
                               Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> HomeDetailPage(homeDetailContent: homeDetailContent.result,
                               campaingId: homeContent[index].campaingId, companyId: homeContent[index].companyId, companyLogo: homeContent[index].companyLogo, companyName: homeContent[index].companyName, contentTitle: homeContent[index].contentTitle,
                               googleAdressLink: homeContent[index].googleAdressLink, companyPhone: homeContent[index].companyPhone.toString())));
                              progressUHD.dismiss();
                            },
                            //---------------------------------------------------------------------------------------------------------------------------------------------------
                            //-----------------------------------------------------------KONUM ICONBUTTON'I----------------------------------------------------------------------
                            onPressedLocation: (){
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD.show();
                              int indeks = homeContent[index].companyId;
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>WebViewWidget(locationUrl: homeContent[indeks-1].googleAdressLink))); 
                              progressHUD.dismiss();
                            },
                            //-----------------------------------------------------------------------------------------------------------------------------------------------------
                            //------------------------------LİKE BUTTON----------------------------------------
                            likeButton: 
                            IconButton( icon: homeContent[index].liked ? Icon(Icons.favorite,color: primaryColor) : Icon(LineIcons.heart, color: primaryColor),
                            onPressed: () async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              userIdData = prefs.getInt("userIdData"); 
                              LikeJsn likePostData = await likeJsnFunc(userIdData, homeContent[index].campaingId);
                              print(likePostData.success);
                              print(likePostData.result);
                              await  refreshContentStream();
                            }),
                            //--------------------------------------------------------------------------------------
                            //----------------------------------------FAVORİTE BUTTON--------------------------------
                            starButton: IconButton(
                             icon: homeContent[index].favoriStatus ? Icon(Icons.star,size: 26) : Icon(LineIcons.star,size: 26),
                             onPressed:  ()async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              userIdData = prefs.getInt("userIdData"); 
                              final favoriteAdd = await favoriteAddJsnFunc(userIdData,  homeContent[index].companyId);
                              print(favoriteAdd.success);
                              print(favoriteAdd.result);
                              await  refreshContentStream();
                            },
                           ),
                           //--------------------------------------------------------------------------------------
                           homeDetailOntap: () async{
                              final progressUHD = ProgressHUD.of(context);
                              progressUHD.show();
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                               userIdData = prefs.getInt("userIdData");  
                              final ContentStreamDetailJsn homeDetailContent = await contentStreamDetailJsnFunc(homeContent[index].companyId, homeContent[index].campaingId,userIdData);                        
                              // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
                               Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> HomeDetailPage(homeDetailContent: homeDetailContent.result,
                               campaingId: homeContent[index].campaingId, companyId: homeContent[index].companyId, companyLogo: homeContent[index].companyLogo, companyName: homeContent[index].companyName, contentTitle: homeContent[index].contentTitle,
                               googleAdressLink: homeContent[index].googleAdressLink, companyPhone: homeContent[index].companyPhone.toString())));
                              progressUHD.dismiss();
                            },
                            logoOnTap: ()async{
                              final progressUHD = ProgressHUD.of(context);
                              progressUHD.show(); 
                              final CompanyProfileJsn companyProfile = await companyListDetailJsnFunc(homeContent[index].companyId);
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> CompanyProfilePage(companyProfile: companyProfile)));
                              progressUHD.dismiss();
                            },
                          );
                          //-------------------------------------------------------------------------------------
                          }),
                      ),
                    )
                  ],
                ),
              ),
            ) : circularBasic
          ),
        ),
      ),
    );
  }
}
