import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:estetikvitrini/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class CompanyInformationPage extends StatefulWidget {
  CompanyInformationPage({Key key}) : super(key: key);

  @override
  _CompanyInformationPageState createState() => _CompanyInformationPageState();
}

class _CompanyInformationPageState extends State<CompanyInformationPage> {

  TextEditingController teCompanyName = TextEditingController();
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
                          child: Text("companyManager / companyName",  
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
                            image: AssetImage("assets/images/logo.png")))),
                        ),
                        Container(
                          width: deviceWidth(context),
                          child: TextButtonWidget(
                            buttonText: "Firma Logosu Seçiniz",
                            onPressed: (){},
                          ),
                        ),
                        TextFieldWidget(
                          hintText: "Firma İsmi",
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
                          textEditingController: teCompanyName,
                        ),
                        TextFieldWidget(
                          hintText: "Firma Telefon - 1",
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          textEditingController: teCompanyName,
                        ),
                        TextFieldWidget(
                          hintText: "Firma Telefon - 2",
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          textEditingController: teCompanyName,
                        ),
                        TextFieldWidget(
                          hintText: "Firma Google Linki",
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          textEditingController: teCompanyName,
                        ),
                        TextFieldWidget(
                          hintText: "Firma Adresi",
                          obscureText: false,
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          textEditingController: teCompanyName,
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