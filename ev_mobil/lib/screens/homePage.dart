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
import '../settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  static const route = "/homePage";
  int cityDenemeID ;

  HomePage({Key key, this.cityDenemeID}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(cityDenemeID: cityDenemeID);
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
        child: homeContent != null ? Builder(builder: (context)=>       
              Container(
              color: Colors.white,
              child: Column(
              children: [
                  //-----------------------------Header-------------------------------
                  // Bir arama Textfield'ı içerir
                  Padding(
                    padding: const EdgeInsets.only(left: maxSpace, right: maxSpace),
                    child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Estetik Vitrini", 
                    style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(color: primaryColor, fontFamily: leadingFont)),
                      ),
                    ),
                  ),
                  //------------------------------------------------------------------
                  //---------------------------Story Paneli---------------------------
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: maxSpace, right: maxSpace),
                      child: GridView.builder(
                        itemCount: companyContent.length,
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: maxSpace,
                        crossAxisSpacing: 0,
                        childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height/2),
                        crossAxisCount: 1),
                        itemBuilder: (BuildContext context,index){
                          return Column(children:[
                              GestureDetector(
                              child:  Stack(children:[
                                Container(
                                  //Genişlik - yükseklik eşit verilip shape circle verilerek şekillendirildi
                                    width: 82,
                                    height: 82,
                                    decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  //   gradient: LinearGradient(
                                  //   //storyColor ile mor - beyaz renkleri liste haline getirildi,
                                  //   //gradient ile center olarak konumlandırılıp dış çerçeve oluşturuldu
                                  //   colors: storyColor,
                                  //   begin: Alignment.center,
                                  //   end: Alignment.center,
                                  // ),
                                  ),
                            ),
                            Padding(padding: const EdgeInsets.all(2.0), // mor rengin genişliğini ayaralar
                                    child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                    border: Border.all(
                                    color: primaryColor,
                                    width: 2.0, // beyaz rengin genişliğini ayarlar
                                  ),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                    image: NetworkImage(companyContent[index].companyLogo),
                                  ),
                                  ),
                                ),
                              ),
                          ],
                              ),
                          onTap: (){
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>StoryPage(company: companies[index])));
                          },),
                          Text(companyContent[index].companyName),
                        ],
                          );
                        }),
                    )
                  ),
                  //--------------------------------------------------------------------------------------------
                  SizedBox(height: deviceHeight(context)*0.01), // story - postlar arası boşluk
                  //------------------------------------Anasayfa Postları----------------------------------------
                  Container(
                    child: Flexible(
                      flex: 5,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: homeContent == null ? 0 : homeContent.length,
                        itemBuilder: (BuildContext context, int index){
                        return HomeContainerWidget(
                          companyLogo   : homeContent[index].companyLogo,
                          companyName   : homeContent[index].companyName,
                          contentPicture: homeContent[index].contentPicture,
                          cardText      : homeContent[index].contentTitle,
                          pinColor      : primaryColor,
                          //------------------------------------------"DETAYLI BİLGİ İÇİN" BUTONU-----------------------------------------------
                          onPressed: () async{
                          final progressUHD = ProgressHUD.of(context);
                          progressUHD.show(); 
                          final ContentStreamDetailJsn homeDetailContent = await contentStreamDetailJsnFunc(homeContent[index].companyId, homeContent[index].campaingId);                        
                          // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeDetailPage(homeDetailContent: homeDetailContent.result,homeContent: homeContent,)));
                          progressUHD.dismiss();
                        },
                        //--------------------------------------------------------------------------------------------------------------------
                        //-----------------------------------------------KONUM ICONBUTTON'I----------------------------------------------------
                        onPressedLocation: (){
                          final progressUHD = ProgressHUD.of(context);
                          progressUHD.show();
                          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>GoogleMapPage(locationUrl: homeContent[index].googleAdressLink)));
                          progressUHD.dismiss();
                        },
                        //-------------------------------------------------------------------------------------------------------------------
                      );
                      }),
                    ),
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
