// ignore_for_file: unnecessary_null_comparison
import 'dart:io';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:estetikvitrini/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<String> base64imagesList = []; // base64 resimler listesi
  List<File> imageList = []; // seçilip kırpılmış resimler listesi
  //late Key contentKey;

   String user = "";

   getUserName() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String? newuser = prefs.getString("namesurname");
   setState(() {
     user = newuser!; 
   });
   }

  final ImagePicker imgpicker = ImagePicker();

    DateTime? startdDate;
    DateTime? finishedDate;

    String getStartDate(){
      if(startdDate == null){
        return "";
      }
      else{
        return (startdDate!.day <= 9 ? "0"+startdDate!.day.toString() :  startdDate!.day.toString())+"."+ 
        (startdDate!.month <= 9 ? "0"+startdDate!.month.toString() :  startdDate!.month.toString()) +"."+startdDate!.year.toString();
      }
    }
  
    String getFinishedDate(){
      if(finishedDate == null){
        return "";
      }
      else{
        return (finishedDate!.day <= 9 ? "0"+finishedDate!.day.toString() :  finishedDate!.day.toString())+"."+ 
        (finishedDate!.month <= 9 ? "0"+finishedDate!.month.toString() :  finishedDate!.month.toString()) +"."+finishedDate!.year.toString();
      }
    }
  @override
  Widget build(BuildContext context) {
        //var keyEditor;
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
                          child: Text(user,  
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
                        borderRadius: BorderRadius.vertical(top: Radius.circular(cardCurved)),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            base64imagesList != null ?
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: imageList.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index){
                                return Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: AspectRatio(
                                    aspectRatio: 16/9,
                                    child: Container(
                                      width: deviceWidth(context)*0.8,
                                      height: deviceHeight(context)*0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(maxSpace)),
                                        color: secondaryTransparentColor,
                                        image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: FileImage(imageList[index]))),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          icon: Icon(Icons.cancel_outlined,size: 30, color: primaryColor),
                                          onPressed: (){
                                              print(index.toString() + " silindi");
                                              imageList.removeAt(index);
                                              base64imagesList.removeAt(index);
                                              setState(() {});
                                          }, 
                                      )),
                                    ),
                                  ),
                                );

                            })
                            : Container(),
                            Padding(
                            padding: const EdgeInsets.only(top: maxSpace),
                            child: Container(
                            width: deviceWidth(context),
                            child: TextButtonWidget(
                            buttonText: "Fotoğraf Ekle",
                            onPressed: () => setSelectedImage(), // openImages(),
                               ),
                              ),
                            ),
                             Padding(
                                      padding: EdgeInsets.only(top: deviceHeight(context)*0.01, bottom: deviceHeight(context)*0.01),
                                      child: Padding(
                                        padding:  EdgeInsets.only(left: maxSpace),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              child: Container(
                                                width: deviceWidth(context)/2.5,
                                                height: deviceHeight(context)*0.04,
                                              child: Center(
                                                child: Text(getStartDate() == "" ? "Başlangıç Tarihi" : getStartDate(),
                                                  style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontFamily: contentFont
                                                )),
                                              ),
                                              decoration: BoxDecoration(
                                                color: secondaryColor,
                                                border: Border.all(color: Colors.grey),
                                                borderRadius: BorderRadius.all(Radius.circular(minSpace))
                                              ),
                                              ),
                                              onTap: ()async{
                                                pickStartDate(context);
                                                //String html = await contentKey.currentState?.getHtml();//////////////////////
                                               // print(html);
                                              },
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                width: deviceWidth(context)/2.5,
                                                height: deviceHeight(context)*0.04,
                                              child: Center(
                                                child: Text(getFinishedDate() == "" ? "Bitiş Tarihi" : getFinishedDate(),
                                                  style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontFamily: contentFont
                                                )),
                                              ),
                                              decoration: BoxDecoration(
                                                color: secondaryColor,
                                                border: Border.all(color: Colors.grey),
                                                borderRadius: BorderRadius.all(Radius.circular(minSpace))
                                              ),
                                              ),
                                              onTap: ()=> pickFinishedDate(context),
                                            ),
                                          ],
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

                          //  Padding(
                          //    padding: const EdgeInsets.all(maxSpace),
                          //    child: Container(
                          //      decoration: BoxDecoration(
                          //        borderRadius: BorderRadius.all(Radius.circular(maxSpace)),
                          //        border: Border.all()),
                          //      width: deviceWidth(context),
                          //      height: deviceHeight(context)/3,
                          //      child: RichEditor(
                          //       key: contentKey,
                          //       value: "Kampanya İçeriğini Giriniz",
                          //       editorOptions: RichEditorOptions(
                          //         placeholder: 'Start typing',
                          //         // backgroundColor: Colors.blueGrey, // Editor's bg color
                          //         // baseTextColor: Colors.white,
                          //         // editor padding
                          //         padding: EdgeInsets.symmetric(horizontal: 5.0),
                          //         // font name
                          //         baseFontFamily: 'sans-serif',
                          //         // Position of the editing bar (BarPosition.TOP or BarPosition.BOTTOM)
                          //         barPosition: BarPosition.TOP,
                          //       ),
                          //     ),
                          //    ),
                          //  ),

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
                            onPressed: () async{
                              //String html = await contentKey.currentState?.getHtml();
                              //print(html);
                              
                              final progressUHD = ProgressHUD.of(context);
                              progressUHD!.show(); 
                              if(getStartDate() != "" && getFinishedDate() != "" && teLeading.text != "" && base64imagesList != null && base64imagesList != [] ){
                              final addCampaignData = await campaignAddJsnFunc(0,1,getStartDate(),getFinishedDate(),teLeading.text,teContent.text,base64imagesList);
                              print(addCampaignData);
                              if(addCampaignData!.success == true){
                                showToast(context, "Kampanya başarıyla kaydedildi !");
                                Navigator.of(context).pop();
                              }
                              else{
                                showToast(context, "Kampanya kaydı başarısız !");
                              }
                              }
                              else{
                              showToast(context, "Lütfen boş alanları doldurunuz!");
                            }
                              progressUHD.dismiss();
                            },
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
        imageCrop(selectedImage!); 
        imageList.add(selectedImage!);
        base64Image = imageToBase64(selectedImage!);
        base64imagesList.add(base64Image!);
      }
    });   
  }

  

  void imageCrop(File image) async{
  File? croppedImage = await ImageCropper.cropImage(
  sourcePath: image.path,
  aspectRatioPresets: [
    CropAspectRatioPreset.ratio16x9
  ]
);

  if(croppedImage != null){
    setState(() {
      selectedImage = croppedImage;
    });
  }
 }

// openImages() async {
// try {
//     var pickedfiles = await imgpicker.pickMultiImage();
//     //you can use ImageCourse.camera for Camera capture
//     if(pickedfiles != null){
//         imagefiles = pickedfiles;
//         setState(() {
//         });
//     }else{
//         print("No image is selected.");
//     }
// }catch (e) {
//     print("error while picking file.");
// }
//   }

 Future pickStartDate(BuildContext context) async{
   final initialDate = DateTime.now();
   final newDate = await showDatePicker(
     context: context, 
     initialDate: startdDate ?? initialDate, 
     firstDate: DateTime(DateTime.now().year -1), 
     lastDate: DateTime(DateTime.now().year + 1),
     builder: (context, child) {
      return Theme(
      data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: secondaryColor),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary
          ),
          textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: secondaryColor,
          ),
        ),
      ),
      child: child!,
      );
    },
  );

  if(newDate == null) return;
  setState(() {
    startdDate = newDate;
  });
   
 }

  Future pickFinishedDate(BuildContext context) async{
   final initialDate = DateTime.now();
   final newDate = await showDatePicker(
     context: context, 
     initialDate: finishedDate ?? initialDate, 
     firstDate: DateTime(DateTime.now().year -1), 
     lastDate: DateTime(DateTime.now().year + 1),
     builder: (context, child) {
      return Theme(
      data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: secondaryColor),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary
          ),
          textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: secondaryColor,
          ),
        ),
      ),
      child: child!,
      );
    },
  );

  if(newDate == null) return;
  setState(() {
    finishedDate = newDate;
  });
   
 }
}