import 'dart:async';

import 'package:estetikvitrini/JsnClass/contentStreamJsn.dart';
import 'package:estetikvitrini/screens/homeDetailPage.dart';
import 'package:estetikvitrini/screens/storyPage.dart';
import 'package:estetikvitrini/settings/connection.dart';
import 'package:estetikvitrini/widgets/homeContainerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import '../settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';

class HomePage extends StatefulWidget {
  static const route = "/homePage";
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController teSearch = TextEditingController();

//---------------------------INTERNET KONTROLÜ STREAM'I------------------------------
  StreamSubscription _connectionChangeStream;
  bool isOffline = false;

  @override
  void initState() { 
    super.initState();
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

  @override
  Widget build(BuildContext context) {
      List<Widget> homeList = [
      HomeContainerWidget(
       iconNumber: 0,
       imgNumber: 0,
       cardText: "Kendin için bir\nşeyler yap...",
       pinColor: primaryColor,
       onPressed: () {
          // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
         Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeDetailPage()));
       },
     ),

    ];
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: Builder(builder: (context)=>
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
                        itemCount: companies.length,
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: maxSpace,
                        crossAxisSpacing: 0,
                        childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height/3),
                        crossAxisCount: 1),
                        itemBuilder: (BuildContext context,index){
                          return Column(children:[
                              GestureDetector(
                              child:  Container(
                              //Genişlik - yükseklik eşit verilip shape circle verilerek şekillendirildi
                              width: 82,
                              height: 82,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  //storyColor ile mor - beyaz renkleri liste haline getirildi,
                                  //gradient ile center olarak konumlandırılıp dış çerçeve oluşturuldu
                                  colors: storyColor,
                                  begin: Alignment.center,
                                  end: Alignment.center,
                                ),
                              ),
                              child: Padding(padding: const EdgeInsets.all(2.0), // mor rengin genişliğini ayaralar
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: lightWhite,
                                      width: 2.0, // beyaz rengin genişliğini ayarlar
                                    ),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(companies[index].imgUrl),
                                    ),
                                  ),
                                ),
                              ),
                          ),
                          onTap: (){
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>StoryPage(company: companies[index])));
                          },),
                          Text(companies[index].name),
                        ],
                          );
                        }),
                    )
                  ),
                  //-------------------------------------------
                  //------------------------------------Anasayfa Postları----------------------------------------
                  Container(
                    child: Flexible(
                      flex: 4,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: homeList.length,
                        itemBuilder: (BuildContext context, int index){
                        return      HomeContainerWidget(
                        iconNumber: 1,
                        imgNumber: 1,
                        cardText: "",
                        pinColor: primaryColor,
                        onPressed: () async{
                          final progressUHD = ProgressHUD.of(context);
                          progressUHD.show(); 
                          final ContentStreamJsn homeDetailContent = await contentStreamJsnFunc(3);                        
                          // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeDetailPage(homeDetailContent: homeDetailContent)));
                          progressUHD.dismiss();
                        },
                      );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
