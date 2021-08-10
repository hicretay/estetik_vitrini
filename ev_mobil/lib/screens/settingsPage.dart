import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/googleSignInProvider.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/listTileWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
 static const route = "settingsPage";

  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final user = FirebaseAuth.instance.currentUser;

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
                          child: user!=null ? CircleAvatar(backgroundImage: NetworkImage(user.photoURL),radius: 30,) : Icon(Icons.person, color: primaryColor,size: 40),
                  ),
                        ),
                        Text(user != null ? user.email : ""),
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
                          text: "Uygulamadan çıkış yap",
                          child: Icon(Icons.exit_to_app,color: white),
                          onTap: (){
                          final progressUHD = ProgressHUD.of(context); 
                          progressUHD.show();
                          final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                          provider.logout();
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


