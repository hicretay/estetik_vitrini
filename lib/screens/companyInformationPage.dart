import 'package:estetikvitrini/JsnClass/companyProfile.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:estetikvitrini/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

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
                          child: Container(
                            width: deviceWidth(context),
                            height: deviceHeight(context)*0.15,
                            decoration: BoxDecoration(
                            image: DecorationImage(
                            image: NetworkImage(companyProfile!.result!.companyLogo!)))),
                        ),
                        Container(
                          width: deviceWidth(context),
                          child: TextButtonWidget(
                            buttonText: "Firma Logosu Seçiniz",
                            onPressed: (){},
                          ),
                        ),
                        TextFieldWidget(
                          hintText: companyProfile!.result!.companyName == null || companyProfile!.result!.companyName == "" ? "Firma Adı" : companyProfile!.result!.companyName,
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          textEditingController: teCompanyName,
                        ),
                        TextFieldWidget(
                          hintText: companyProfile!.result!.eMail == null || companyProfile!.result!.eMail == "" ? "Firma E-Posta" : companyProfile!.result!.eMail,
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          textEditingController: teEPosta,
                        ),
                        TextFieldWidget(
                          hintText: companyProfile!.result!.companyPhone == null ||  companyProfile!.result!.companyPhone == "" ? "Firma Telefonu" :  companyProfile!.result!.companyPhone,
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          textEditingController: teTel1,
                        ),
                        TextFieldWidget(
                          hintText: companyProfile!.result!.companyPhone2 == null || companyProfile!.result!.companyPhone2 == "" ? "Firma Telefonu 2" : companyProfile!.result!.companyPhone2,
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          textEditingController: teTel2,
                        ),
                        TextFieldWidget(
                          hintText: companyProfile!.result!.web == null || companyProfile!.result!.web == "" ? "Firma Google Linki" : companyProfile!.result!.web,
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          textEditingController: teWeb,
                        ),
                        TextFieldWidget(
                          hintText: companyProfile!.result!.googleAdressLink == null || companyProfile!.result!.googleAdressLink == "" ? "Firma Adresi" : companyProfile!.result!.googleAdressLink,
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          textEditingController: teGoogleAddress,
                        ),
                        Container(
                          width: deviceWidth(context),
                          child: TextButtonWidget(
                            buttonText: "Firma Bilgilerini Kaydet",
                            onPressed: (){},
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
}