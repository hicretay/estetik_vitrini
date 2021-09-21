import 'package:estetikvitrini/JsnClass/contentStreamDetailJsn.dart';
import 'package:estetikvitrini/JsnClass/likeJsn.dart';
import 'package:estetikvitrini/screens/googleMapPage.dart';
import 'package:estetikvitrini/screens/homeDetailPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/homeContainerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchResultPage extends StatefulWidget {
  SearchResultPage({Key key}) : super(key: key);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  List homeContent = []; 
  int userIdData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      color: secondaryColor,
      child: ListView.builder(itemBuilder: (BuildContext context, int index){
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
        final ContentStreamDetailJsn homeDetailContent = await contentStreamDetailJsnFunc(homeContent[index].companyId, homeContent[index].campaingId);                        
        // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
         Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> HomeDetailPage(homeDetailContent: homeDetailContent.result,
         campaingId: homeContent[index].campaingId, companyId: homeContent[index].companyId, companyLogo: homeContent[index].companyLogo, companyName: homeContent[index].companyName, contentTitle: homeContent[index].contentTitle,
         googleAdressLink: homeContent[index].googleAdressLink)));
        progressUHD.dismiss();
      },
      //---------------------------------------------------------------------------------------------------------------------------------------------------
      //-----------------------------------------------------------KONUM ICONBUTTON'I----------------------------------------------------------------------
      onPressedLocation: (){
        final progressHUD = ProgressHUD.of(context);
        progressHUD.show();
        int indeks = homeContent[index].companyId;
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>GoogleMapPage(locationUrl: homeContent[indeks-1].googleAdressLink))); 
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
        //await  refreshContentStream();
      }),
      //--------------------------------------------------------------------------------------
      //----------------------------------------FAVORİTE BUTTON--------------------------------
      starButton: IconButton(
       icon: Icon(LineIcons.star,size: 26),
       onPressed:  ()async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        userIdData = prefs.getInt("userIdData"); 
        final favoriteAdd = await favoriteAddJsnFunc(userIdData,  homeContent[index].companyId);
        print(favoriteAdd.success);
        print(favoriteAdd.result);
      },
     ),
     homeDetailOntap: () async{
        final progressUHD = ProgressHUD.of(context);
        progressUHD.show(); 
        final ContentStreamDetailJsn homeDetailContent = await contentStreamDetailJsnFunc(homeContent[index].companyId, homeContent[index].campaingId);                        
        // "Detaylı Bilgi İçin" butouna basıldığında detay sayfasına yönlendirecek
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> HomeDetailPage(homeDetailContent: homeDetailContent.result,
        campaingId: homeContent[index].campaingId, companyId: homeContent[index].companyId, companyLogo: homeContent[index].companyLogo, companyName: homeContent[index].companyName, contentTitle: homeContent[index].contentTitle,
        googleAdressLink: homeContent[index].googleAdressLink)));
        progressUHD.dismiss();
      },
    ); 
      })),
    );
  }
}