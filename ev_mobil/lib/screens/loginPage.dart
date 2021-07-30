import 'package:ev_mobil/screens/registerPage.dart';
import 'package:ev_mobil/settings/consts.dart';
import 'package:ev_mobil/settings/root.dart';
import 'package:ev_mobil/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  static const route = "/loginPage";
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ProgressHUD(
        child: Builder(builder: (context)=>
            Stack(children:[
              Container(
                decoration: BoxDecoration(gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [secondaryColor,primaryColor],
                  )),
                child: null,
            ),
            SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(children: [
                  SizedBox(height: deviceHeight(context) * 0.3), // giriş ikonu - cihaz üstü boşluk          
                       //--------------------------giriş ikonu----------------------------------
                        Center(child: SvgPicture.asset("assets/images/logobeyaz.svg")),  
                       //------------------------------------------------------------------
                        SizedBox(height: deviceHeight(context) * 0.1),
                        SingleChildScrollView(
                          reverse: true,
                          child: Column(children: [
                                //--------------------Kullanıcı textField'ı---------------------
                                Padding(padding: const EdgeInsets.only(top: defaultPadding,right: defaultPadding,left: defaultPadding),
                                  child       : TextFieldWidget(textEditingController: txtUsername,
                                  keyboardType: TextInputType.name,
                                  hintText    : "Telefon veya E-Posta", //ipucu metni
                                  obscureText : false, // yazılanlar gizlenmesin
                                ),
                            ),
                            //-------------------------Şifre textField'ı------------------------
                          Padding(padding: const EdgeInsets.only(top: defaultPadding,right: defaultPadding,left: defaultPadding),
                              child: TextFieldWidget(
                              textEditingController: txtPassword,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText : true, // yazılanlar gizlensin
                              hintText    : "Şifre", //ipucu metni
                            ),
                          ),
                          //------------------------------------------------------------------
                          SizedBox(height: deviceHeight(context)*0.1),
                          Material(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(30.0),
                            child: MaterialButton(
                              minWidth: deviceWidth(context) * 0.4, //Buton minimum genişliği
                              child: Text("Giriş",style: Theme.of(context).textTheme.button.copyWith(color: white,fontFamily: contentFont,fontSize: 20)),
                              onPressed: (){
                                final progressUHD = ProgressHUD.of(context);
                                progressUHD.show(); 
                                Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) => Root()), (route) => false);    
                                progressUHD.dismiss(); 
                            }),
                          ),
                          SizedBox(height: deviceHeight(context)*0.01),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                SizedBox(width: deviceWidth(context)*0.2),
                                TextButton(
                                child: Text("Şifremi Unuttum",style: TextStyle(color: secondaryColor,fontFamily: contentFont,fontSize: 16),),
                                onPressed: (){}, 
                                ),
                                SizedBox(width: deviceWidth(context)*0.05),
                                TextButton(
                                child: Text("Kayıt Ol",style: TextStyle(color: secondaryColor,fontFamily: contentFont,fontSize: 16),),
                                onPressed: (){
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => RegisterPage())); 
                                }, 
                                ),
                                SizedBox(width: deviceWidth(context)*0.2),
                              ],
                          ),
                            
                          ],),
                        )
                ],),
              ),
            ),
          ],
            ),
        ),
      ),
    );
  }
}