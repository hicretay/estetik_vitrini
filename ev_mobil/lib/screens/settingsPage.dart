import 'package:estetikvitrini/providers/themeDataProvider.dart';
import 'package:estetikvitrini/screens/aboutPage.dart';
import 'package:estetikvitrini/screens/loginPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/listTileWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: Builder(builder:(context)=>
              BackGroundContainer(
              colors: backGroundColor1,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    Column(
                      children: 
                        [Padding(
                          padding: const EdgeInsets.only(top: defaultPadding),
                          child: Text("Profil",
                          style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(color: white, fontFamily: leadingFont)),
                        ),
                        
                      ],
                    ),
                    
                    Column(
                      children: [ 
                        SizedBox(height: deviceHeight(context)*0.05),
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: primaryColor,
                          child: CircleAvatar(
                          backgroundColor: secondaryColor,
                          radius: 30,
                          child:  Icon(Icons.person, color: primaryColor,size: 40),
                  ),
                        ),
                        Text(""),
                        SizedBox(height: maxSpace),
                      ],
                    ),
                  ],
                ),

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(cardCurved)),//Yalnızca dikeyde yuvarlatılmış
                        ),
                    child: ListView(
                      children: [
                        SizedBox(height: defaultPadding),
                          ListTileWidget(
                          text: "Lisans Bilgileri",
                          child: LineIcon(LineIcons.fileAlt,color: white),
                          onTap: (){
                            final progressUHD = ProgressHUD.of(context);
                            progressUHD.show(); 
                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>AboutPage()));
                            progressUHD.dismiss();
                          },
                        ), 
                        ListTileWidget(
                          text: "Gizlilik Sözleşmesi ve KVKK Bildirimi",
                          child: LineIcon(LineIcons.fileContract,color: white),
                        ), 
                        ListTileWidget(
                          text: "Estetik Vitrini Hakkında",
                          child: LineIcon(LineIcons.infoCircle,color: white),
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
    );
  }
}


