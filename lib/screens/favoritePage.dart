import 'package:estetikvitrini/JsnClass/companyProfile.dart';
import 'package:estetikvitrini/JsnClass/contentStreamDetailJsn.dart';
import 'package:estetikvitrini/JsnClass/contentStreamJsn.dart';
import 'package:estetikvitrini/screens/companyProfilePage.dart';
import 'package:estetikvitrini/widgets/webViewWidget.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/homeContainerWidget.dart';
import 'package:estetikvitrini/screens/homeDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoritePage extends StatefulWidget {
  static const route = "/favoritePage";

  FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  TextEditingController teSearch = TextEditingController();
  List? favoriContent;
  int? userIdData;
  bool checked = false;

  @override
  void initState() { 
    super.initState();
    favoriContentList();
  }

  Future favoriContentList() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userIdData = prefs.getInt("userIdData"); 
  final ContentStreamJsn? favoriContentNewList = await favoriteJsnFunc(userIdData!,0,true); 
  setState(() {
     favoriContent = favoriContentNewList!.result;
  });
}

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: ProgressHUD(
            child: Builder(builder: (context)=>
                BackGroundContainer(
                child: Column(        
                  children: [
                  Padding(padding: const EdgeInsets.all(defaultPadding),
                  //--------------Scaffold Görünümlü header--------------
                  child: Padding(
                    padding: const EdgeInsets.only(top: defaultPadding*2),
                    child: Column(
                      children: [
                        Align(alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("favori salonlarım", //Büyük Başlık
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(color: white, fontFamily: leadingFont),
                                maxLines: 2,
                              ),
                              Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(                           
                                child: SvgPicture.asset("assets/icons/refresh.svg",height: 30,width: 30, color: white),
                                onTap:(){
                                  favoriContentList();
                                  showToast(context, "Sayfa yenilendi");
                                },
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                    //------------------------------------------------------------------
                  ),
                    //------------------------------------------------------------------
                    //------------------------- Arkaplan containerı---------------------
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(cardCurved)),//Yalnızca dikeyde yuvarlatılmış
                        ),
                        child: RefreshIndicator(
                          onRefresh:()=> favoriContentList(),
                          color: primaryColor,
                          backgroundColor: secondaryColor,
                          child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemCount: favoriContent == null ? 0 : favoriContent!.length,
                            controller: NavigationProvider.of(context).screens[FAVORITE_PAGE].scrollController, 
                            itemBuilder: (BuildContext context, int index){
                              return HomeContainerWidget(
                              companyLogo   : favoriContent![index].companyLogo,
                              companyName   : favoriContent![index].companyName,
                              contentPicture: favoriContent![index].contentPicture,
                              cardText      : favoriContent![index].contentTitle,
                              pinColor      : primaryColor,
                              onPressedPhone: () async{ 
                                              dynamic number = favoriContent![index].companyPhone.toString(); // arama ekranına yönlendirme
                                              launch("tel://$number");
                                            },
                              //------------------------------------------"DETAYLI BİLGİ İÇİN" BUTONU-----------------------------------------------
                              onPressed: () async{
                              final progressUHD = ProgressHUD.of(context);
                              progressUHD!.show(); 
                                 SharedPreferences prefs = await SharedPreferences.getInstance();
                               userIdData = prefs.getInt("userIdData")!; 
                              final ContentStreamDetailJsn? homeDetailContent = await contentStreamDetailJsnFunc(favoriContent![index].companyId, favoriContent![index].campaingId,userIdData!); 
                              // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> HomeDetailPage(homeDetailContent: homeDetailContent?.result, 
                              campaingId: favoriContent![index].campaingId, companyId: favoriContent![index].companyId, 
                              companyLogo: favoriContent![index].companyLogo, companyName: favoriContent![index].companyName, 
                              contentTitle: favoriContent![index].contentTitle, companyPhone: favoriContent![index].companyPhone.toString())));
                              progressUHD.dismiss();
                            },
                            //--------------------------------------------------------------------------------------------------------------------
                            //-----------------------------------------------KONUM ICONBUTTON'I----------------------------------------------------
                            onPressedLocation: (){
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD!.show();
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>WebViewWidget(locationUrl: favoriContent![index].googleAdressLink)));
                              progressHUD.dismiss();
                            },
                            //-------------------------------------------------------------------------------------------------------------------
                            //---------------------------------------------LİKE BUTTON------------------------------------------------------
                            likeButton: 
                              IconButton( icon: favoriContent![index].liked ? SvgPicture.asset("assets/icons/heart-focus.svg",height: 22,width: 22,color: primaryColor) : SvgPicture.asset("assets/icons/heart.svg",height: 25,width: 25),
                              onPressed: () async{
                                 final progressHUD = ProgressHUD.of(context);
                                 progressHUD!.show();
                                 SharedPreferences prefs = await SharedPreferences.getInstance();
                                 userIdData = prefs.getInt("userIdData")!; 
                                 if(userIdData != 0){
                                   final likePostData = await likeJsnFunc(userIdData!, favoriContent![index].campaingId);
                                   await favoriContentList();
                                   progressHUD.dismiss();
                                   print(likePostData!.success);
                                   print(likePostData.result);
                                 }
                                 else{
                                   showNotMemberAlert(context);
                                 }
                                 
                              }),
                              //------------------------------------------------------------------------------------------------------------
                              //------------------------------------------FAVORİTE BUTTON-----------------------------------------
                              starButton: IconButton(
                               icon: SvgPicture.asset("assets/icons/star-focus.svg",height: 22,width: 22,color: primaryColor),
                               onPressed:  ()async{
                                final progressHUD = ProgressHUD.of(context);
                                progressHUD!.show();
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                userIdData = prefs.getInt("userIdData")!; 
                                if(userIdData != 0){
                                  final favoriteAdd = await favoriteAddJsnFunc(userIdData!, favoriContent![index].companyId);
                                  await favoriContentList(); 
                                  progressHUD.dismiss();
                                  print(favoriteAdd!.success);
                                  print(favoriteAdd.result);
                                progressHUD.dismiss();
                                }
                                else{
                                  showNotMemberAlert(context);
                                }
                                
                              },
                             ),
                             //------------------------------------------------------------------------------------------------------------
                             homeDetailOntap: () async{
                              final progressUHD = ProgressHUD.of(context);
                              progressUHD!.show(); 
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              userIdData = prefs.getInt("userIdData")!; 
                              final ContentStreamDetailJsn? homeDetailContent = await contentStreamDetailJsnFunc(favoriContent![index].companyId, favoriContent![index].campaingId,userIdData!); 
                              // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> HomeDetailPage(homeDetailContent: homeDetailContent!.result, 
                              campaingId: favoriContent![index].campaingId, companyId: favoriContent![index].companyId, 
                              companyLogo: favoriContent![index].companyLogo, companyName: favoriContent![index].companyName, 
                              contentTitle: favoriContent![index].contentTitle, companyPhone: favoriContent![index].companyPhone.toString())));
                              progressUHD.dismiss();
                            },
                            logoOnTap: ()async{
                              final progressUHD = ProgressHUD.of(context);
                              progressUHD!.show(); 
                              final CompanyProfileJsn? companyProfile = await companyListDetailJsnFunc(favoriContent![index].companyId);
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> CompanyProfilePage(companyProfile: companyProfile)));
                              progressUHD.dismiss();
                            },
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
      ),
    );
  }
}
