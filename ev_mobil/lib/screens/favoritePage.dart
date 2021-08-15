import 'package:estetikvitrini/JsnClass/contentStreamDetailJsn.dart';
import 'package:estetikvitrini/JsnClass/contentStreamJsn.dart';
import 'package:estetikvitrini/JsnClass/favoriCompanyJsn.dart';
import 'package:estetikvitrini/screens/googleMapPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/homeContainerWidget.dart';
import 'package:estetikvitrini/screens/homeDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class FavoritePage extends StatefulWidget {
  static const route = "/favoritePage";

  FavoritePage({Key key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  TextEditingController teSearch = TextEditingController();
  FavoriCompanyJsn favoriContent;
  int counter = 99;

  @override
  void initState() { 
    super.initState();
    favoriContentList();
  }

  Future favoriContentList() async{
  final FavoriCompanyJsn favoriContentNewList = await favoriCompanyJsnFunc(3); 
  setState(() {
     favoriContent = favoriContentNewList;
  });
}

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
                        itemCount: favoriContent.result == null ? 0 : favoriContent.result.length,
                        controller: NavigationProvider.of(context)
                        .screens[FAVORITE_PAGE]
                        .scrollController,
                        itemBuilder: (BuildContext context, int index){
                          return HomeContainerWidget(
                          companyLogo   : favoriContent?.result[index].companyLogo,
                          companyName   : favoriContent?.result[index].companyName,
                          contentPicture: favoriContent?.result[index].contentPicture,
                          cardText      : favoriContent?.result[index].contentTitle,
                          pinColor      : primaryColor,
                          //------------------------------------------"DETAYLI BİLGİ İÇİN" BUTONU-----------------------------------------------
                          onPressed: () async{
                          final progressUHD = ProgressHUD.of(context);
                          progressUHD.show(); 
                          final ContentStreamDetailJsn homeDetailContent = await contentStreamDetailJsnFunc(favoriContent?.result[index].companyId, favoriContent?.result[index].campaingId); 
                          final ContentStreamJsn homeContent = await contentStreamJsnFunc(3);                       
                          // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeDetailPage(homeDetailContent: homeDetailContent, homeContent: homeContent)));
                          progressUHD.dismiss();
                        },
                        //--------------------------------------------------------------------------------------------------------------------
                        //-----------------------------------------------KONUM ICONBUTTON'I----------------------------------------------------
                        onPressedLocation: (){
                          final progressUHD = ProgressHUD.of(context);
                          progressUHD.show();
                          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>GoogleMapPage(locationUrl: favoriContent?.result[index].googleAdressLink)));
                          progressUHD.dismiss();
                        },
                        //-------------------------------------------------------------------------------------------------------------------
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
