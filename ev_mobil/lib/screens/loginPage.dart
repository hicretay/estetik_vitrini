import 'package:estetikvitrini/JsnClass/loginJsn.dart';
import 'package:estetikvitrini/screens/registerPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:estetikvitrini/settings/root.dart';
import 'package:estetikvitrini/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const route = "/loginPage";
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isOnline = false;
  
    @override
    void dispose() {
    txtUsername.dispose();
    txtPassword.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   final loginData = Provider.of<JsonDataProvider>(context, listen: false);
  //   loginData.getLoginData(context);
  // }

  @override
  Widget build(BuildContext context) {
    //final loginData = Provider.of<JsonDataProvider>(context);
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
                    SizedBox(height: deviceHeight(context) * 0.15), // giriş ikonu - cihaz üstü boşluk          
                         //--------------------------giriş ikonu----------------------------------
                          Center(child: SvgPicture.asset("assets/images/logobeyaz.svg")),  
                         //------------------------------------------------------------------
                          SizedBox(height: deviceHeight(context) * 0.05),
                          SingleChildScrollView(
                            reverse: true,
                            child: Column(children: [
                             //--------------------Kullanıcı textField'ı---------------------
                            TextFieldWidget(textEditingController: txtUsername,
                            keyboardType: TextInputType.emailAddress,
                            hintText    : "Telefon veya E-Posta", //ipucu metni
                            obscureText : false, // yazılanlar gizlenmesin
                            ),
                            //-------------------------Şifre textField'ı------------------------
                            TextFieldWidget(
                            textEditingController: txtPassword,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText : true, // yazılanlar gizlensin
                            hintText    : "Şifre", //ipucu metni
                            ),
                            //------------------------------------------------------------------
                            SizedBox(height: deviceHeight(context)*0.05),
                            Material(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(30.0),
                            //--------------------------------------------------GİRİŞ BUTONU---------------------------------------------------------------
                              child: MaterialButton(
                                minWidth: deviceWidth(context) * 0.4, //Buton minimum genişliği
                                child: Text("Giriş",style: Theme.of(context).textTheme.button.copyWith(color: white,fontFamily: contentFont,fontSize: 20)),
                                //-----------------------------GİRİŞ BUTONU ONPRESSEDİ---------------------------------------------
                                onPressed: ()async{
                                  String username = txtUsername.text; // Kullanıcı Adı TextField'ının texti = username
                                  String password = txtPassword.text; // Şifre TextField'ının texti = password
                                  final progressHUD = ProgressHUD.of(context);
                                  progressHUD.show(); 
                                  //--------------------------------USER DATASI DOLDURULMASI---------------------------
                                  final LoginJsn userData = await loginJsnFunc(username, password, false); 
                                  if(userData.success == true){ // Giriş kontrolü, succes
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString("user", username);     
                                  prefs.setString("pass", password);    
                                  Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)=>Root()));
                                  NavigationProvider.of(context).setTab(LOCATION_PAGE);
                                  progressHUD.dismiss(); 
                                  }
                                  else{
                                    showAlert(context, "Kullanıcı adı veya şifre yanlış!");
                                  }

                                  progressHUD.dismiss(); 
                              }),
                            //-----------------------------------------------------------------------------------------------------------------------------
                            ),
                            SizedBox(height: deviceHeight(context)*0.05),
                            TextButton(
                            child: Text("Kayıt Ol",style: TextStyle(color: secondaryColor,fontFamily: contentFont,fontSize: 16)),
                            onPressed: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterPage())); 
                            }, 
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: defaultPadding*3,right: defaultPadding*3),
                              child: Divider(height: 2,color: primaryColor,thickness: 0.8,),
                            ),
                            SizedBox(height: deviceHeight(context)*0.05),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children:[
                  // //----------------------------EMAİL LOGİN BUTONU----------------------------------
                  //             GestureDetector(
                  //               child: CircleAvatar(
                  //               backgroundColor: secondaryColor,
                  //               maxRadius: deviceWidth(context)*0.06,
                  //               child: FaIcon(FontAwesomeIcons.envelopeSquare,
                  //               color: primaryColor,)),
                  //               onTap: (){
                  //                 Navigator.push(context,
                  //                 MaterialPageRoute(builder: (context) => RegisterPage())); 
                  //               },),
                  //             SizedBox(width: deviceWidth(context)*0.05),
                  // //-----------------------------GOOGLE LOGİN BUTONU---------------------------------
                  //             GestureDetector(
                  //               child: CircleAvatar(
                  //               backgroundColor: secondaryColor,
                  //               maxRadius: deviceWidth(context)*0.06,
                  //               child: FaIcon(FontAwesomeIcons.google,
                  //               color: primaryColor,
                  //               )),
                  //               onTap: (){
                  //                 final progressUHD = ProgressHUD.of(context);
                  //                 progressUHD.show();
                  //                 try{
                  //                   final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                  //                   provider.googleLogin();
                  //                 }
                  //                 catch(error){
                  //                   print("error");
                  //                   return null;
                  //                 }

                  //                 progressUHD.dismiss();
                  //               }),
                  // //----------------------------------------------------------------------------------
                  //             SizedBox(width: deviceWidth(context)*0.05),
                  // //------------------------------FACEBOOK LOGİN BUTONU--------------------------------
                  //             GestureDetector(
                  //               child: CircleAvatar(
                  //               backgroundColor: secondaryColor,
                  //               maxRadius: deviceWidth(context)*0.06,
                  //               child: FaIcon(FontAwesomeIcons.facebookF,
                  //               color: primaryColor,)),
                  //               onTap: ()async{
                  //                 final progressUHD = ProgressHUD.of(context);
                  //                 progressUHD.show();

                  //                 // FacebookPermissions  permissions = await FacebookAuth.instance.permissions;
                  //                 // final LoginResult result = await FacebookAuth.instance.login(
                  //                 //   permissions: ["public_profile","email"],
                  //                 // ); 
                  //                 // if (result.status == LoginStatus.success) {
                  //                 //     print("you are logged");
                  //                 //     // ignore: unused_local_variable
                  //                 //     final AccessToken accessToken = result.accessToken;
                  //                 //     Navigator.pushAndRemoveUntil(context,
                  //                 //     MaterialPageRoute(builder: (context) => Root()), (route) => false);
                  //                 // }
                  //                 // else{
                  //                 //   showToast(context,"Giriş Başarısız !");
                  //                 // }
                                  

                  //                 // FacebookAuth.instance.login(
                  //                 //   permissions: ["public_profile","email"],
                  //                 // ).then((value){
                  //                 //   FacebookAuth.instance.getUserData().then((userData){
                  //                 //     setState(() {
                  //                 //         isOnline = true;
                  //                 //         userObject = userData;
                  //                 //     });
                  //                 //   });
                  //                 //  isOnline?
                  //                 //  showToast(context,"Giriş Başarısız !"):
                  //                 //  Navigator.pushAndRemoveUntil(context,
                  //                 //  MaterialPageRoute(builder: (context) => Root()), (route) => false);
                  //                 //  progressUHD.dismiss(); 
                  //                 // }
                  //                 // );

                  //                 // final AccessToken accessToken = await FacebookAuth.instance.accessToken;
                  //                 // if (accessToken != null) {
                  //                 //     print("başarılı");
                  //                 //     print(userObject["email"]);
                  //                 //     Navigator.pushAndRemoveUntil(context,
                  //                 //     MaterialPageRoute(builder: (context) => Root()), (route) => false);
                  //                 // }
                  //                 // progressUHD.dismiss(); 
                  //               }),
                  // //-----------------------------------------------------------------------------------
                  //               ]),
                                SizedBox(height: deviceHeight(context)*0.04),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: TextButton(
                                  child: Text("Şifremi Unuttum",style: TextStyle(color: secondaryColor,fontFamily: contentFont,fontSize: 16)),
                                  onPressed: (){}, 
                                  ),
                                ),                          
                            ]),
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