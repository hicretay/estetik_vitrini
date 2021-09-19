import 'package:estetikvitrini/JsnClass/contentStreamDetailJsn.dart';
import 'package:estetikvitrini/JsnClass/contentStreamJsn.dart';
import 'package:estetikvitrini/providers/themeDataProvider.dart';
import 'package:estetikvitrini/screens/googleMapPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/homeContainerWidget.dart';
import 'package:estetikvitrini/screens/homeDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  static const route = "/favoritePage";

  FavoritePage({Key key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  TextEditingController teSearch = TextEditingController();
  List favoriContent;
  int userIdData;
  bool checked = false;

  @override
  void initState() { 
    super.initState();
    favoriContentList();
  }

  Future favoriContentList() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userIdData = prefs.getInt("userIdData"); 
  final ContentStreamJsn favoriContentNewList = await favoriteJsnFunc(userIdData,0,true); 
  setState(() {
     favoriContent = favoriContentNewList.result;
  });
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: Builder(builder: (context)=>
              BackGroundContainer(
              colors: Provider.of<ThemeDataProvider>(context, listen: true).isLightTheme ? backGroundColor1 : backGroundColorDark,
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
                            .headline3
                            .copyWith(color: white, fontFamily: leadingFont),
                      ),
                    ),
                  ),
                  //-----------------------------------------------------------------
                  //------------------------- Arkaplan containerı---------------------
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(cardCurved)),//Yalnızca dikeyde yuvarlatılmış
                      ),
                      child: RefreshIndicator(
                        onRefresh:()=> favoriContentList(),
                        color: primaryColor,
                        backgroundColor: secondaryColor,
                        child: ListView.builder(
                          itemCount: favoriContent == null ? 0 : favoriContent.length,
                          controller: NavigationProvider.of(context)
                          .screens[FAVORITE_PAGE]
                          .scrollController,
                          itemBuilder: (BuildContext context, int index){
                            return HomeContainerWidget(
                            companyLogo   : favoriContent[index].companyLogo,
                            companyName   : favoriContent[index].companyName,
                            contentPicture: favoriContent[index].contentPicture,
                            cardText      : favoriContent[index].contentTitle,
                            pinColor      : primaryColor,
                            //------------------------------------------"DETAYLI BİLGİ İÇİN" BUTONU-----------------------------------------------
                            onPressed: () async{
                            final progressUHD = ProgressHUD.of(context);
                            progressUHD.show(); 
                            final ContentStreamDetailJsn homeDetailContent = await contentStreamDetailJsnFunc(favoriContent[index].companyId, favoriContent[index].campaingId); 
                            // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> HomeDetailPage(homeDetailContent: homeDetailContent.result, 
                            campaingId: favoriContent[index].campaingId, companyId: favoriContent[index].companyId, 
                            companyLogo: favoriContent[index].companyLogo, companyName: favoriContent[index].companyName, 
                            contentTitle: favoriContent[index].contentTitle)));
                            progressUHD.dismiss();
                          },
                          //--------------------------------------------------------------------------------------------------------------------
                          //-----------------------------------------------KONUM ICONBUTTON'I----------------------------------------------------
                          onPressedLocation: (){
                            final progressHUD = ProgressHUD.of(context);
                            progressHUD.show();
                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>GoogleMapPage(locationUrl: favoriContent[index].googleAdressLink)));
                            progressHUD.dismiss();
                          },
                          //-------------------------------------------------------------------------------------------------------------------
                          //---------------------------------------------LİKE BUTTON------------------------------------------------------
                          likeButton: 
                            IconButton( icon: favoriContent[index].liked ? Icon(Icons.favorite,color: primaryColor) : Icon(LineIcons.heart, color: primaryColor),
                            onPressed: () async{
                               final progressHUD = ProgressHUD.of(context);
                               progressHUD.show();
                               SharedPreferences prefs = await SharedPreferences.getInstance();
                               userIdData = prefs.getInt("userIdData"); 
                               final likePostData = await likeJsnFunc(userIdData, favoriContent[index].campaingId);
                               await favoriContentList();
                               progressHUD.dismiss();
                               print(likePostData.success);
                               print(likePostData.result);
                            }),
                            //------------------------------------------------------------------------------------------------------------
                            //------------------------------------------FAVORİTE BUTTON-----------------------------------------
                            starButton: IconButton(
                             icon: Icon(Icons.star,size: 26, color: primaryColor),
                             onPressed:  ()async{
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD.show();
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              userIdData = prefs.getInt("userIdData"); 
                              final favoriteAdd = await favoriteAddJsnFunc(userIdData,  favoriContent[index].campaingId);
                              progressHUD.dismiss();
                              print(favoriteAdd.success);
                              print(favoriteAdd.result);
                              favoriContentList(); 
                              progressHUD.dismiss();
                            },
                           ),
                           //------------------------------------------------------------------------------------------------------------
                        );
                        }),
                      ),
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
