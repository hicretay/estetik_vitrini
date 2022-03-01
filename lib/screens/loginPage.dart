import 'package:estetikvitrini/JsnClass/loginJsn.dart';
import 'package:estetikvitrini/screens/locationPage.dart';
import 'package:estetikvitrini/screens/registerPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const route = "/loginPage";
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtForgetPassword = TextEditingController();
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
                    SizedBox(height: deviceHeight(context)*0.15),
                         //--------------------------giriş ikonu----------------------------------
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Container(
                              width: deviceWidth(context),
                              height: deviceWidth(context)*0.3,
                              child: Center(child: SvgPicture.asset("assets/images/logobeyaz.svg",color: white, placeholderBuilder: (context)=> circularBasic))),
                          ), 
                         //------------------------------------------------------------------
                        // dikdörtgen olan 1228 3443  ----- tümü 3787 2985 -------- sadece yazı olan 10529 1639(6.42)
                          SingleChildScrollView(
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
                                child: Text("Giriş",style: Theme.of(context).textTheme.button!.copyWith(color: white,fontFamily: contentFont,fontSize: 20)),
                                //-----------------------------GİRİŞ BUTONU ONPRESSEDİ---------------------------------------------
                                onPressed: ()async{
                                  final progressHUD = ProgressHUD.of(context);
                                  progressHUD!.show(); 
                                  String username = txtUsername.text; // Kullanıcı Adı TextField'ının texti = username
                                  String password = txtPassword.text; // Şifre TextField'ının texti = password
                                  if(username != "" && password != ""){
                                  
                                  //--------------------------------USER DATASI DOLDURULMASI---------------------------
                                  final LoginJsn? userData = await loginJsnFunc(username, password, false); 
                                  if(userData!.success == true){ // Giriş kontrolü, succes
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString("namesurname", userData.result!.nameSurname!);
                                  prefs.setString("user", username);     
                                  prefs.setString("pass", password);  
                                  prefs.setBool("isAdmin", userData.result!.admin!);
                                  prefs.setInt("userIdData", userData.result!.id!);  
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LocationPage()), (route) => false);
                                  showToast(context, "Giriş Başarılı!");
                                  progressHUD.dismiss(); 
                                  }
                                  else{
                                    showAlert(context, "Kullanıcı adı veya şifre yanlış!");
                                  }

                                  }
                                  else{
                                    showAlert(context, "Kullanıcı adı veya şifre boş geçilemez!");
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
                            // Padding(
                            //   padding: const EdgeInsets.only(left: defaultPadding*3,right: defaultPadding*3),
                            //   child: Divider(height: 2,color: primaryColor,thickness: 0.8,),
                            // ),
                            //SizedBox(height: deviceHeight(context)*0.05),
                            Padding(padding: const EdgeInsets.only(right: defaultPadding*2,left: defaultPadding*2,bottom: minSpace),
                            child     : Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            color     : primaryColor),
                            //--------------------------------------UYE OLMADAN DEVAM ET BUTONU---------------------------------------------
                            child     : TextButton(
                            style     : ButtonStyle(),
                            child     : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children  : [Text("Üye olmadan devam et",
                            style     : TextStyle(
                            color     : darkWhite,
                            fontSize  : 15,
                            fontFamily: contentFont)),
                            FaIcon(FontAwesomeIcons.arrowRight,size: 18,color: white)
                            ]),
                            onPressed : () async{
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD!.show(); 
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setBool("isAdmin", false);
                              prefs.setString("namesurname", "Deneme Hesabı");   
                              prefs.setInt("userIdData", 0);   
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LocationPage()), (route) => false);
                              showToast(context, "Giriş Başarılı!");
                              progressHUD.dismiss();
                            },
                            ),
                            //-----------------------------------------------------------------------------------------------------------
                          ),
                        ),

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
                                  onPressed: (){
                                    showDialog(context: context, builder: (BuildContext context){
                                    return ProgressHUD(
                                      child: Builder(builder: (context)=>  
                                          AlertDialog(
                                          title: Center(child: Text("SIFREMI UNUTTUM", style: TextStyle(fontFamily: leadingFont))),
                                          content: Container(
                                            height: 70,
                                            child: Column(
                                              children: [
                                                Text("Lütfen E-Posta adresinizi giriniz: "),
                                                SizedBox(height: minSpace),
                                                TextField(
                                                  controller: txtForgetPassword,
                                                  keyboardType: TextInputType.emailAddress,
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.all(maxSpace),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(cardCurved),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                          Row(mainAxisAlignment: MainAxisAlignment.center,
                                             children: [
                                               MaterialButton(
                                               color: primaryColor,
                                               child: Text("Gönder",style: TextStyle(fontFamily: leadingFont,color: white)), // fotoğraf çekilmeye devam edilecek
                                               onPressed: () async{
                                                 final progressHUD = ProgressHUD.of(context);
                                                 progressHUD!.show(); 
                                                 final forgetPasswordData = await forgetPasswordJsnFunc(txtForgetPassword.text.trim());
                                                 if(forgetPasswordData!.success == true){
                                                   showToast(context, "Lütfen mail aresinizi kontrol ediniz !");
                                                 }
                                                 else{
                                                   showToast(context, "Bir hata oluştu !");
                                                 }
                                                 Navigator.of(context).pop();
                                                 progressHUD.dismiss();
                                              }),
                                            ]),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                  }, 
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