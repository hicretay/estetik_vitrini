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
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import '../settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  static const route = "/homePage";

  HomePage({Key key,}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List homeContent = []; 
  int pageIndex = 1;
  int totalPage = 1;

  TextEditingController teSearch = TextEditingController();

  List companyContent;

//---------------------------INTERNET KONTROLÜ STREAM'I------------------------------
  StreamSubscription _connectionChangeStream;
  bool isOffline = false;
//-----------------------------------------
  final RefreshController refreshController = RefreshController(initialRefresh: true);

  Future<bool> getData({bool isRefresh = false}) async{
    if(isRefresh){
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
    body: '{"userId":' + 1.toString() + ',' + '"page":' + pageIndex.toString() + '}',
    headers: header
  );

  if (response.statusCode == 200) {
    final result = contentStreamJsnFromJson(response.body);
    if(isRefresh){
      homeContent = result.result;
    }
    else{
      homeContent.addAll(result.result);
      }
    setState(() {
          pageIndex++;
          totalPage = result.totalPage;
        });
    return true;
  } else {
    return false;
  }
  }


  @override
  void initState() { 
    super.initState();
    getData();
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

  //  Future homeContentList() async{
  //    final ContentStreamJsn homeContentNewList = await contentStreamJsnFunc(1,pageIndex); 
  //    setState(() {
  //       homeContent = homeContentNewList.result;
  //    });
  //  }

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
                            int lastCompId = companyContent.last.id;
                            Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(builder: (context)=>StoryPage(company: companyContent, storyIndex: index, lastCompId: lastCompId)));
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
                    padding: EdgeInsets.only(top:58+deviceWidth(context)*0.2+20),
                    child: SmartRefresher(
                      controller: refreshController,
                      enablePullUp: true,
                      footer: CustomFooter(
                      builder: (BuildContext context,LoadStatus mode){
                        Widget body ;
                        if(mode==LoadStatus.idle){
                          body =  Text("Daha fazla kampanya yükle");
                        }
                        else if(mode==LoadStatus.loading){
                          body = circularBasic;
                        }
                        else if(mode == LoadStatus.failed){
                          body = Text("Yükleme hatası !");
                        }
                        else if(mode == LoadStatus.canLoading){
                            body = Text("Gönderiler yükleniyor...");
                        }
                        else{
                          body = Text("Akış sonu");
                        }
                        return Container(
                          height: 35.0,
                          child: Center(child:body),
                        );
                      },
                    ),
                        
                      onRefresh: ()async{
                        final result =await getData(isRefresh: true);
                        if(result){
                          refreshController.refreshCompleted();
                        }
                        else{
                          refreshController.refreshFailed();
                        }
                      },
                      onLoading: ()async{
                         final result =await getData(isRefresh: false);
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
                            liked         : homeContent[index].liked,
                            onPressedPhone: () async{ 
                                            dynamic number = homeContent[index].companyPhone.toString(); // arama ekranına yönlendirme
                                            //bool res = await FlutterPhoneDirectCaller.callNumber(number); // direkt arama
                                            launch("tel://$number");
                                          },
                            //--------------------------------------------------------"DETAYLI BİLGİ İÇİN" BUTONU-------------------------------------------------------------
                            onPressed: () async{
                            final progressUHD = ProgressHUD.of(context);
                            progressUHD.show(); 
                            final ContentStreamDetailJsn homeDetailContent = await contentStreamDetailJsnFunc(homeContent[index].companyId, homeContent[index].campaingId);                        
                            // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
                             Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> HomeDetailPage(homeDetailContent: homeDetailContent.result,homeContent: homeContent,
                             campaingId: homeContent[index].campaingId, companyId: homeContent[index].companyId, companyLogo: homeContent[index].companyLogo, companyName: homeContent[index].companyName, contentTitle: homeContent[index].contentTitle,
                             googleAdressLink: homeContent[index].googleAdressLink)));
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
