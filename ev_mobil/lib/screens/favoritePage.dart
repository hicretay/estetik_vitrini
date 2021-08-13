import 'package:estetikvitrini/JsnClass/contentStreamJsn.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/homeContainerWidget.dart';
import 'package:estetikvitrini/screens/homeDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FavoritePage extends StatefulWidget {
  static const route = "/favoritePage";

  FavoritePage({Key key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  TextEditingController teSearch = TextEditingController();
  int counter = 99;

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
                  //-----------------------Sayfa Başlığı----------------------------
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 20),
                    child: Align(
                      alignment: Alignment.topLeft, // başlık sola bitişik
                      child: Text(
                        "Favori\nSalonlar",
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: white, fontFamily: leadingFont),
                      ),
                    ),
                  ),
                  //----------------------------------------------------------------
                  //------------------------- // Arkaplan containerı------------------
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(cardCurved)),//Yalnızca dikeyde yuvarlatılmış
                      ),
                      child: ListView.builder(
                        itemCount: 1,
                        controller: NavigationProvider.of(context)
                        .screens[FAVORITE_PAGE]
                        .scrollController,
                        itemBuilder: (BuildContext context, int index){
                          return Column(children:[
                            HomeContainerWidget(
                              iconNumber: 0,
                              imgNumber: 1,
                              cardText: "",
                              child: IconButton(
                                 // pin butonu
                                 icon: Icon(FontAwesomeIcons.thumbtack,color: primaryColor,size: 20),
                                 onPressed: (){}, // olayı parametre alındı
                               ),
                              //------------------------------------DETAYLI BİLGİ İÇİN BUTONU ONPPRESSEDİ-------------------------------------------
                              onPressed: () async{
                                final progressUHD = ProgressHUD.of(context);
                                progressUHD.show(); 
                                final ContentStreamJsn homeDetailContent = await contentStreamJsnFunc(3);  
                                 // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeDetailPage(homeDetailContent: homeDetailContent)));
                                progressUHD.dismiss();
                              },
                              //--------------------------------------------------------------------------------------------------------------------
                             ),
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
