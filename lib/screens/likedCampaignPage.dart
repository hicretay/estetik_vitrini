import 'package:estetikvitrini/JsnClass/companyProfile.dart';
import 'package:estetikvitrini/JsnClass/contentStreamDetailJsn.dart';
import 'package:estetikvitrini/JsnClass/likedCampaingJsn.dart';
import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:estetikvitrini/screens/companyProfilePage.dart';
import 'package:estetikvitrini/screens/homeDetailPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/homeContainerWidget.dart';
import 'package:estetikvitrini/widgets/webViewWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LikedCampaignPage extends StatefulWidget {
  static const route = "/likedPage";
  LikedCampaignPage({Key key}) : super(key: key);

  @override
  _LikedCampaignPageState createState() => _LikedCampaignPageState();
}

class _LikedCampaignPageState extends State<LikedCampaignPage> {
  TextEditingController teSearch = TextEditingController();
  List likedContent;
  int userIdData;
  bool checked = false;

  @override
  void initState() { 
    super.initState();
    likedContentList();
  }

  Future likedContentList() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userIdData = prefs.getInt("userIdData"); 
  final LikedCampaingJsn likedContentNewList = await likedCampaingJsnFunc(userIdData); 
  setState(() {
     likedContent = likedContentNewList.result;
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
                    padding: const EdgeInsets.only(left: defaultPadding,right: defaultPadding,top: defaultPadding*2),
                    child: Column(
                      children: [
                        Align(alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("beğenilerim", //Büyük Başlık
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(color: white, fontFamily: leadingFont),
                                maxLines: 2,
                              ),
                              Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                              maxRadius: 20,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                iconSize: iconSize,
                                icon: Icon(Icons.refresh,color: primaryColor),
                                onPressed:(){
                                  likedContentList();
                                  showToast(context, "Sayfa yenilendi");
                                },
                              ),
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
                          onRefresh:()=> likedContentList(),
                          color: primaryColor,
                          backgroundColor: secondaryColor,
                          child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemCount: likedContent == null ? 0 : likedContent.length,
                            controller: NavigationProvider.of(context).screens[FAVORITE_PAGE].scrollController, 
                            itemBuilder: (BuildContext context, int index){
                              return HomeContainerWidget(
                              companyLogo   : likedContent[index].companyLogo,
                              companyName   : likedContent[index].companyName,
                              contentPicture: likedContent[index].contentPicture,
                              cardText      : likedContent[index].contentTitle,
                              pinColor      : primaryColor,
                              onPressedPhone: () async{ 
                                              dynamic number = likedContent[index].companyPhone.toString(); // arama ekranına yönlendirme
                                              launch("tel://$number");
                                            },
                              //------------------------------------------"DETAYLI BİLGİ İÇİN" BUTONU-----------------------------------------------
                              onPressed: () async{
                              final progressUHD = ProgressHUD.of(context);
                              progressUHD.show(); 
                                 SharedPreferences prefs = await SharedPreferences.getInstance();
                               userIdData = prefs.getInt("userIdData"); 
                              final ContentStreamDetailJsn homeDetailContent = await contentStreamDetailJsnFunc(likedContent[index].companyId, likedContent[index].campaingId,userIdData); 
                              // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> HomeDetailPage(homeDetailContent: homeDetailContent.result, 
                              campaingId: likedContent[index].campaingId, companyId: likedContent[index].companyId, 
                              companyLogo: likedContent[index].companyLogo, companyName: likedContent[index].companyName, 
                              contentTitle: likedContent[index].contentTitle, companyPhone: likedContent[index].companyPhone.toString())));
                              progressUHD.dismiss();
                            },
                            //--------------------------------------------------------------------------------------------------------------------
                            //-----------------------------------------------KONUM ICONBUTTON'I----------------------------------------------------
                            onPressedLocation: (){
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD.show();
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>WebViewWidget(locationUrl: likedContent[index].googleAdressLink)));
                              progressHUD.dismiss();
                            },
                            //-------------------------------------------------------------------------------------------------------------------
                            //---------------------------------------------LİKE BUTTON------------------------------------------------------
                            likeButton: 
                              IconButton( icon: likedContent[index].liked ? SvgPicture.asset("assets/icons/heart-focus.svg",height: 22,width: 22,color: primaryColor,) : SvgPicture.asset("assets/icons/heart.svg",height: 25,width: 25),
                              onPressed: () async{
                                 final progressHUD = ProgressHUD.of(context);
                                 progressHUD.show();
                                 SharedPreferences prefs = await SharedPreferences.getInstance();
                                 userIdData = prefs.getInt("userIdData"); 
                                 final likePostData = await likeJsnFunc(userIdData, likedContent[index].campaingId);
                                 await likedContentList();
                                 progressHUD.dismiss();
                                 print(likePostData.success);
                                 print(likePostData.result);
                              }),
                              //------------------------------------------------------------------------------------------------------------
                              //------------------------------------------FAVORİTE BUTTON-----------------------------------------
                              starButton: IconButton(
                               icon: likedContent[index].favoriStatus ? SvgPicture.asset("assets/icons/star-focus.svg",height: 22,width: 22,color: primaryColor)  :  SvgPicture.asset("assets/icons/star.svg",height: 25,width: 25),
                               onPressed:  ()async{
                                final progressHUD = ProgressHUD.of(context);
                                progressHUD.show();
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                userIdData = prefs.getInt("userIdData"); 
                                final favoriteAdd = await favoriteAddJsnFunc(userIdData,  likedContent[index].campaingId);
                                progressHUD.dismiss();
                                print(favoriteAdd.success);
                                print(favoriteAdd.result);
                                likedContentList(); 
                                progressHUD.dismiss();
                              },
                             ),
                             //------------------------------------------------------------------------------------------------------------
                             homeDetailOntap: () async{
                              final progressUHD = ProgressHUD.of(context);
                              progressUHD.show(); 
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              userIdData = prefs.getInt("userIdData"); 
                              final ContentStreamDetailJsn homeDetailContent = await contentStreamDetailJsnFunc(likedContent[index].companyId, likedContent[index].campaingId,userIdData); 
                              // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> HomeDetailPage(homeDetailContent: homeDetailContent.result, 
                              campaingId: likedContent[index].campaingId, companyId: likedContent[index].companyId, 
                              companyLogo: likedContent[index].companyLogo, companyName: likedContent[index].companyName, 
                              contentTitle: likedContent[index].contentTitle, companyPhone: likedContent[index].companyPhone.toString())));
                              progressUHD.dismiss();
                            },
                            logoOnTap: ()async{
                              final progressUHD = ProgressHUD.of(context);
                              progressUHD.show(); 
                              final CompanyProfileJsn companyProfile = await companyListDetailJsnFunc(likedContent[index].companyId);
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