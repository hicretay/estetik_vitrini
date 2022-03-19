// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:estetikvitrini/JsnClass/companyProfile.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:estetikvitrini/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

class CompanyInformationPage extends StatefulWidget {
  final CompanyProfileJsn? companyProfile;
  CompanyInformationPage({Key? key, this.companyProfile}) : super(key: key);

  @override
  _CompanyInformationPageState createState() => _CompanyInformationPageState(companyProfile: companyProfile);
}

class _CompanyInformationPageState extends State<CompanyInformationPage> {
  CompanyProfileJsn? companyProfile;
  _CompanyInformationPageState({this.companyProfile});

  TextEditingController teCompanyName = TextEditingController();
  TextEditingController teEPosta = TextEditingController();
  TextEditingController teTel1 = TextEditingController();
  TextEditingController teTel2= TextEditingController();
  TextEditingController teWeb = TextEditingController();
  TextEditingController teGoogleAddress = TextEditingController();
  
  int? userIdData;
  File? selectedImage; // seçilen fotoğraf
  String? base64Image; // base64'e dönüşmüş fotoğraf

  @override
  void initState() {
    teCompanyName.text = (companyProfile!.result!.companyName == null || companyProfile!.result!.companyName == "" ? "" : companyProfile!.result!.companyName)!;
    teEPosta.text = (companyProfile!.result!.eMail == null || companyProfile!.result!.eMail == "" ? "" : companyProfile!.result!.eMail)!;
    teTel1.text = (companyProfile!.result!.companyPhone == null ||  companyProfile!.result!.companyPhone == "" ? "" :  companyProfile!.result!.companyPhone)!;
    teTel2.text = (companyProfile!.result!.companyPhone2 == null || companyProfile!.result!.companyPhone2 == "" ? "" : companyProfile!.result!.companyPhone2)!;
    teWeb.text = (companyProfile!.result!.web == null || companyProfile!.result!.web == "" ? "" : companyProfile!.result!.web)!;
    teGoogleAddress.text = (companyProfile!.result!.googleAdressLink == null || companyProfile!.result!.googleAdressLink == "" ? "" : companyProfile!.result!.googleAdressLink)!;

    // setState(() {
    //   if(base64Image == null){
    //     existingImage = File(companyProfile!.result!.companyLogo!);                                
    //     imageToBase64(existingImage!);
    //     print(existingImage);
    //   }
    // });
    super.initState();
  }

  // Future<File?> fileFromImageUrl() async {
  //   final response = await http.get(Uri.parse(companyProfile!.result!.companyLogo!));
  //   final documentDirectory = await getApplicationDocumentsDirectory();
  //   existingImage = File(join(documentDirectory.path, "image.png"));
  //   existingImage!.writeAsBytesSync(response.bodyBytes);
  //   return existingImage;
  // }

  @override
  Widget build(BuildContext context) {
        return SafeArea(
        child: Scaffold(
        body: ProgressHUD(
        child: Builder(builder: (context)=>
              BackGroundContainer(
              child: Column(
              children: [
                Padding(padding: const EdgeInsets.all(maxSpace),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(//iconun çevresini saran yapı tasarımı
                        maxRadius: 20,
                        backgroundColor: Colors.white,
                        child: IconButton(
                        iconSize: iconSize,
                        icon: Icon(Icons.arrow_back,color: primaryColor),
                        onPressed: (){ Navigator.pop(context, false);}
                        ),
                      ),
                      SizedBox(width: maxSpace),
                      Text("Firma Bilgileri",
                      style     : TextStyle(
                      fontFamily: leadingFont, 
                      fontSize  : 25, 
                      color     : Colors.white),
                      ),
                    ],
                  ),
                ],
              )),
                  Padding(padding: const EdgeInsets.only(left: defaultPadding),
                      child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(companyProfile!.result!.companyName!,  
                          style: TextStyle(color: Colors.white,fontSize: 20),
                          ),
                        ),
                        SizedBox(height: maxSpace)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(cardCurved)),//Yalnızca dikeyde yuvarlatılmış
                      ),
                      child: ListView(children: [
                        Padding(
                          padding: const EdgeInsets.all(maxSpace),
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80,
                             // backgroundImage: selectedImage != null ? FileImage(selectedImage!,scale: 2) : null,

                              child: selectedImage == null ? Image.network(companyProfile!.result!.companyLogo!,fit: BoxFit.cover,) : 
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(shape: BoxShape.circle),
                                child: Image.file(selectedImage!,fit: BoxFit.cover))
                            ),
                          )
                        ),
                        Container(
                          width: deviceWidth(context),
                          child: TextButtonWidget(
                            buttonText: "Firma Logosu Seçiniz",
                            onPressed: (){
                              setSelectedImage();
                            },
                          ),
                        ),
                        TextFieldWidget(
                          hintText: "Firma Adı",
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          textEditingController: teCompanyName,
                        ),
                        TextFieldWidget(
                          hintText: "Firma E-Posta",
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          textEditingController: teEPosta,
                        ),
                        TextFieldWidget(
                          hintText: "Firma Telefonu",
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          textEditingController: teTel1,
                        ),
                        TextFieldWidget(
                          hintText: "Firma Telefonu 2",
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          textEditingController: teTel2,
                        ),
                        TextFieldWidget(
                          hintText: "Firma Google Linki",
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          textEditingController: teGoogleAddress,
                        ),
                        TextFieldWidget(
                          hintText: "Firma Web Adresi",
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          textEditingController: teWeb,
                        ),
                        Container(
                          width: deviceWidth(context),
                          child: TextButtonWidget(
                            buttonText: "Firma Bilgilerini Kaydet",
                            onPressed: ()async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              userIdData = prefs.getInt("userIdData")!; 
                              final progressHUD = ProgressHUD.of(context);
                              progressHUD!.show(); 
                              final companyData = await companyInfUpdateJsnFunc(
                                 1, 
                                 teCompanyName.text, 
                                 base64Image != null ? base64Image : null,
                                 teTel1.text, 
                                 teTel2.text, 
                                 teGoogleAddress.text, 
                                 teEPosta.text, 
                                 teWeb.text);
                              if(companyData!.success == true){
                                showToast(context, "Firma Bilgileri Güncellendi!");
                              }
                              else{
                                showToast(context, "Bir hata oluştu!");
                              }
                              progressHUD.dismiss();
                            },
                          ),
                        ),
                      ]),
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

  void setSelectedImage() async{
    final picker = ImagePicker();
    final selected = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if(selected != null){
        selectedImage = File(selected.path);
      }
    });
    if(selectedImage != null){
    base64Image = imageToBase64(selectedImage!);
    print(base64Image);
    }
  }
}