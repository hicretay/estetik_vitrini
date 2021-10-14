import 'package:estetikvitrini/providers/themeDataProvider.dart';
import 'package:estetikvitrini/screens/locationPage.dart';
import 'package:estetikvitrini/widgets/webViewWidget.dart';
import 'package:estetikvitrini/screens/loginPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/listTileWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
 static const route = "settingsPage";
 SettingsPage({Key key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

   String user = "";

   getUserName() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String newuser = prefs.getString("namesurname");
   setState(() {
     user = newuser; 
   });
   }

   @override
  void initState() {
    getUserName();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: ProgressHUD(
            child: Builder(builder:(context)=>
                BackGroundContainer(
                colors: Provider.of<ThemeDataProvider>(context, listen: true).isLightTheme ? backGroundColor1 : backGroundColorDark,
                child: Column(children: [
                  SizedBox(height: deviceHeight(context)*0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:[                    
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: defaultPadding),
                            child: Column(
                              children: [Text("Profil",
                              style: Theme.of(context)
                                      .textTheme
                                      .headline3
                                      .copyWith(color: white, fontFamily: leadingFont)),
                                Text(user,style: TextStyle(color: white,fontSize: 16)),
                                SizedBox(height: deviceHeight(context)*0.01),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      Column(
                        children: [ 
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: primaryColor,
                            child: CircleAvatar(
                            backgroundColor: secondaryColor,
                            radius: 30,
                            child:  Icon(Icons.person, color: primaryColor,size: 40),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(cardCurved)),//Yalnızca dikeyde yuvarlatılmış
                          ),
                      child: ListView(
                        padding: EdgeInsets.all(0),
                        children: [
                          SizedBox(height: defaultPadding),
                            ListTileWidget(
                            text: "Lisans Sözleşmesi",
                            child: LineIcon(LineIcons.fileAlt,color: white),
                            onTap: (){
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD.show(); 
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>WebViewWidget(locationUrl: "https://aynaayna.biz/lisanssozlesmesi.html")));  
                              progressHUD.dismiss();
                            },
                          ), 
                           ListTileWidget(
                            text: "Kullanım Sözleşmesi",
                            child: LineIcon(LineIcons.fileAlt,color: white),
                            onTap: (){
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD.show(); 
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>WebViewWidget(locationUrl: "https://aynaayna.biz/kullanimsozlesmesi.html")));  
                              progressHUD.dismiss();
                            },
                          ),
                          ListTileWidget(
                            text: "Gizlilik Bildirimi",
                            child: LineIcon(LineIcons.fileContract,color: white),
                            onTap: (){
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD.show(); 
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>WebViewWidget(locationUrl: "https://aynaayna.biz/gizlilikbildirimi.html"))); 
                              progressHUD.dismiss();
                            },
                          ), 
                          ListTileWidget(
                            text: "Estetik Vitrini Hakkında",
                            child: LineIcon(LineIcons.infoCircle,color: white),
                            onTap: (){
                              showAlert(context, "     Estetik Vitrini; güzellik salonu, kuaför ve dövme salonu gibi güzellik merkezlerini arayan, kendisi için en uygun güzellik uygulamaları hakkında bilgi edinmek isteyen, bu konuda rehberliğe ihtiyaç duyan, istediği güzellik ve bakım hizmetini nereden alabileceğine karar verme aşamasında olanların kullanacağı sektörel bir sosyal medya platformudur.\n     Güzellik merkezleri bu platform içinde salonlarını açabilir; salonlarını, hizmetlerini ve tavsiyelerini müşterilerine tanıtabilir.");
                            },
                          ),
                          ListTileWidget(
                            text: "Favori Konumlar",
                            child: SvgPicture.asset("assets/icons/haritanoktası.svg",height: 25,width: 25, color: white),
                            onTap: ()async{
                             SharedPreferences prefs = await SharedPreferences.getInstance();
                             prefs.setString("isFirstLogin", "Favori Konumlar");
                             Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> LocationPage()));
                            },
                          ),
                          ListTileWidget(
                            text: Provider.of<ThemeDataProvider>(context, listen: true).isLightTheme ? "Koyu temaya geç" : "Açık temaya geç",
                            child: Switch(
                              activeColor: secondaryColor,
                              onChanged: (_) async{
                              Provider.of<ThemeDataProvider>(context, listen: false).toggleTheme();
                            }, 
                            value: Provider.of<ThemeDataProvider>(context, listen: true).isLightTheme),
                          ), 
                          ListTileWidget(
                            text: "Uygulamadan çıkış yap",
                            child: Icon(Icons.exit_to_app,color: white),
                            onTap: ()async{
                            final progressUHD = ProgressHUD.of(context); 
                            progressUHD.show();
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            // shared preferences nesnelerinin silinmesi                
                            prefs.remove("user");
                            prefs.remove("pass");
                            prefs.remove("userIdData");    
                            prefs.remove("namesurname");  
                            prefs.remove("isFirstLogin");                  
                            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
                            progressUHD.dismiss();
                          }),
                        ],
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


