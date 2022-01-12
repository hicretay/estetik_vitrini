import 'package:estetikvitrini/screens/newCampaignPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:line_icons/line_icons.dart';

class CampaignOperationPage extends StatefulWidget {
  CampaignOperationPage({Key? key}) : super(key: key);

  @override
  _CampaignOperationPageState createState() => _CampaignOperationPageState();
}

class _CampaignOperationPageState extends State<CampaignOperationPage> {
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
                      Text("Kampanya Islemleri",
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
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: maxSpace),
                          child: Container(
                            width: deviceWidth(context),
                            child: TextButtonWidget(
                              buttonText: "Yeni Kampanya Oluştur",
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>NewCampaignPage()));
                              },
                            ),
                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index){
                          return buildCampaignCard(context);
                        })
                      ]),
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

  Padding buildCampaignCard(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(maxSpace),
    child: Column(
    children: [
      //-----------------------------Postu çevreleyecek container yapısı-----------------------------
            AspectRatio(
            aspectRatio: 1.5,
            child: Material(
            borderRadius:  BorderRadius.circular(cardCurved),
            elevation: 10,
            child: Container(                           
            width: double.infinity, 
            decoration: BoxDecoration(
              color: lightWhite,
              borderRadius: BorderRadius.circular(cardCurved),
            ),
            child: Column(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                    //--------------Resmi çevreyelecek container yapısı------------------
                    child: Container(
                    
                    width: deviceWidth(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(maxSpace),
                        image: DecorationImage(
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                      //------------------------------------------------------------------
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                  child: Align(alignment: Alignment.bottomLeft, 
                  child: Container(
                    width: deviceWidth(context),
                    padding: EdgeInsets.all(minSpace),
                    decoration: BoxDecoration(
                      color:  secondaryTransparentColor,
                    ),
                    child: Text(
                      "campaign leading", 
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                 ),
                ),
                //-------------------------------------ICONBUTTONLAR PANELİ----------------------------------------
                Padding(
                  padding:const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                  child: Container(
                  width: deviceWidth(context),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, //Tüm widgetlar container altına konumlandırılsın
                  children: [
                    //-----------------Butonların yer aldığı container--------------------
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(minSpace),
                      ),
                      width: double.infinity, // genişlik: container kadar
                      height: 40,
                      child: Row(
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                            //------------------------------SİLME ICONBUTTONI----------------------------
                              IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(LineIcons.trash,
                                color: primaryColor),
                                onPressed: (){},),
                            //------------------------------------------------------------------------------
                            //-----------------------------DÜZENLEME ICONBUTTONI--------------------------------
                              IconButton(
                                padding: EdgeInsets.all(0),
                              icon: Icon(LineIcons.edit,
                              color: primaryColor,
                              size : iconSize),
                              onPressed: (){},)
                            //------------------------------------------------------------------------------
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //------------------------------------------------------------------
                  ],
                )),
                ),
                //-------------------------------------------------------------------------------------------------
                SizedBox(height: maxSpace),
              ],
            ),
          ),
        ),
      ),
    ]),
  );
 }
}