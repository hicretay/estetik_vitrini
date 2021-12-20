import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:estetikvitrini/screens/appointmentOperationPage.dart';
import 'package:estetikvitrini/screens/campaignOperationPage.dart';
import 'package:estetikvitrini/screens/companyInformationPage.dart';
import 'package:estetikvitrini/screens/locationPage.dart';
import 'package:estetikvitrini/widgets/backleadingWidget.dart';
import 'package:estetikvitrini/widgets/webViewWidget.dart';
import 'package:estetikvitrini/screens/loginPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/listTileWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
 static const route = "settingsPage";
 SettingsPage({Key key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

   String user = "";
   bool isAdmin = false;

   getUserName() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String newuser = prefs.getString("namesurname");
   setState(() {
     user = newuser; 
   });
   }

   getIsAdmin()async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   bool newAdminData = prefs.getBool("isAdmin");
   setState(() {
     isAdmin = newAdminData; 
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
                child: Column(children: [
                  SizedBox(height: deviceHeight(context)*0.05),
                  BackLeadingWidget(
                  backColor: primaryColor,
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:[                    
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: maxSpace),
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
                        controller: NavigationProvider.of(context).screens[LIKED_PAGE].scrollController,
                        padding: EdgeInsets.all(0),
                        children: [
                          SizedBox(height: defaultPadding),
                          isAdmin == true ? 
                            Column(children: [
                               ListTileWidget(
                            text: "Kampanya İşlemleri",
                            child: FaIcon(FontAwesomeIcons.tags,size: 16,color: white),
                            onTap: (){
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD.show(); 
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> CampaignOperationPage()));  
                              progressHUD.dismiss();
                            },
                          ),
                          ListTileWidget(
                            text: "Gelen Randevular",
                            child: FaIcon(FontAwesomeIcons.calendarCheck,size: 18,color: white),
                            onTap: (){
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD.show(); 
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> AppointmentOperationPage()));    
                              progressHUD.dismiss();
                            },
                          ),
                          ListTileWidget(
                            text: "Firma Bilgileri",
                            child: FaIcon(FontAwesomeIcons.questionCircle,size: 18,color: white),
                            onTap: (){
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD.show(); 
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=> CompanyInformationPage()));      
                              progressHUD.dismiss();
                            },
                          ),
                            SizedBox(height: maxSpace), //Post altı - divider arası boşluk
                              Divider(
                              //İki post arasında yer alan çizgi
                              indent: 100.0,
                              endIndent: 100.0,
                              height: 1,
                              color: secondaryColor,
                              thickness: 1.5,
                            ),
                          ]) : Container(),
                            SizedBox(height: minSpace), // Post üstü - divider arası boşluk
                            ListTileWidget(
                            text: "Lisans Sözleşmesi",
                            child: LineIcon(LineIcons.fileContract,color: white),
                            onTap: (){
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD.show(); 
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>WebViewWidget(locationUrl: "https://estetikvitrini.com/license.html")));  
                              progressHUD.dismiss();
                            },
                          ), 
                          ListTileWidget(
                            text: "Kullanım Sözleşmesi",
                            child: LineIcon(LineIcons.fileSignature,color: white),
                            onTap: (){
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD.show(); 
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>WebViewWidget(locationUrl: "https://estetikvitrini.com/usage.html")));  
                              progressHUD.dismiss();
                            },
                          ),
                          ListTileWidget(
                            text: "Gizlilik Bildirimi",
                            child: LineIcon(LineIcons.file,color: white),
                            onTap: (){
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD.show(); 
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>WebViewWidget(locationUrl: "https://estetikvitrini.com/privacy.html"))); 
                              progressHUD.dismiss();
                            },
                          ), 
                          ListTileWidget(
                            text: "Estetik Vitrini Hakkında",
                            child: LineIcon(LineIcons.infoCircle,color: white),
                            onTap: (){
                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>WebViewWidget(locationUrl: "https://estetikvitrini.com/About.html"))); 
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
                          // ListTileWidget(
                          //   text: Provider.of<ThemeDataProvider>(context, listen: true).isLightTheme ? "Koyu temaya geç" : "Açık temaya geç",
                          //   child: Switch(
                          //     activeColor: secondaryColor,
                          //     onChanged: (_) async{
                          //     Provider.of<ThemeDataProvider>(context, listen: false).toggleTheme();
                          //   }, 
                          //   value: Provider.of<ThemeDataProvider>(context, listen: true).isLightTheme),
                          // ), 
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
                            prefs.remove("isAdmin");               
                            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
                            progressUHD.dismiss();
                          }),
                          SizedBox(height: defaultPadding),
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


