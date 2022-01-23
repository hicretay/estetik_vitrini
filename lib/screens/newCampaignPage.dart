// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:estetikvitrini/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:image_picker/image_picker.dart';

class NewCampaignPage extends StatefulWidget {
  NewCampaignPage({Key? key}) : super(key: key);

  @override
  _NewCampaignPageState createState() => _NewCampaignPageState();
}

class _NewCampaignPageState extends State<NewCampaignPage> {
  TextEditingController teLeading = TextEditingController();
  TextEditingController teContent= TextEditingController();

  int? userIdData;
  File? selectedImage; // seçilen fotoğraf
  String? base64Image; // base64'e dönüşmüş fotoğraf
  List<File?> imagesList = [];
  
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
                      CircleAvatar(
                        maxRadius: 20,
                        backgroundColor: Colors.white,
                        child: IconButton(
                        iconSize: iconSize,
                        icon: Icon(Icons.arrow_back,color: primaryColor),
                        onPressed: (){ Navigator.pop(context, false);}
                        ),
                      ),
                      SizedBox(width: maxSpace),
                      Text("Yeni Kampanya Olustur",
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            imagesList != null ?
                            ListView.builder(
                              itemCount: imagesList.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index){
                                return Container(
                                  width: deviceWidth(context)*0.8,
                                  height: deviceHeight(context)*0.3,
                                decoration: BoxDecoration(image: DecorationImage(image: FileImage(selectedImage!))),
                                );

                            })
                            : Container(),
                            Padding(
                            padding: const EdgeInsets.only(top: maxSpace),
                            child: Container(
                            width: deviceWidth(context),
                            child: TextButtonWidget(
                            buttonText: "Fotoğraf Ekle",
                            onPressed: () => setSelectedImage(),
                               ),
                              ),
                            ),
                             TextFieldWidget(
                             hintText: "Bir Başlık Giriniz",
                             obscureText: false,
                             inputFormatters: [],
                             keyboardType: TextInputType.text,
                             textEditingController: teLeading,
                           ),
                            Padding(
                              padding: const EdgeInsets.only(top: minSpace,right: maxSpace,left: maxSpace),
                              child: TextField(   
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: teContent,
                              cursorColor: primaryColor,
                              style: TextStyle(color: primaryColor, fontSize: 18),
                              decoration: InputDecoration(
                              hintText: "Kampanya İçeriği",
                              hintStyle: TextStyle(
                              color: Colors.black38,
                              fontSize: 17,
                              fontFamily: contentFont),
                              contentPadding: EdgeInsets.symmetric(vertical: deviceHeight(context)*0.07, horizontal: maxSpace),
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(maxSpace),
                               ),
                              focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(maxSpace),
                               ),
                              ),
                              ),
                            ),
                            Padding(
                            padding: const EdgeInsets.only(top: maxSpace),
                            child: Container(
                            width: deviceWidth(context),
                            child: TextButtonWidget(
                            buttonText: "Kampanyayı Kaydet",
                            onPressed: (){},
                              ),
                             ),
                           ),
                          ],
                        ),
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
    void setSelectedImage() async{
    final picker = ImagePicker();
    final selected = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if(selected != null){
        selectedImage = File(selected.path);       
      }
    });   
    if(selectedImage != null){
    imagesList.add(selectedImage!);
    base64Image = imageToBase64(selectedImage!);
    }
  }
  
}