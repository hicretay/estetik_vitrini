import 'package:estetikvitrini/JsnClass/companyProfile.dart';
import 'package:estetikvitrini/screens/newCampaignPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CampaignOperationPage extends StatefulWidget {
  final CompanyProfileJsn? companyProfile;

  CampaignOperationPage({Key? key, this.companyProfile}) : super(key: key);

  @override
  _CampaignOperationPageState createState() => _CampaignOperationPageState(companyProfile: companyProfile);
}

class _CampaignOperationPageState extends State<CampaignOperationPage> {
  CompanyProfileJsn? companyProfile;
  _CampaignOperationPageState({this.companyProfile});

  Future refreshCampaignList() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    int? userIdData = prefs.getInt("userIdData"); 
    final CompanyProfileJsn? companyNewProfile = await companyListDetailJsnFunc(1); //userIdData
    setState(() {
      companyProfile = companyNewProfile!;
    });
  }

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
                      Text("Kampanya İşlemleri",
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
                    child: RefreshIndicator(
                      onRefresh:()=> refreshCampaignList(),
                      color: primaryColor,
                      backgroundColor: secondaryColor,
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
                            itemCount: companyProfile!.result!.campaignList!.length,
                            itemBuilder: (BuildContext context, int index){
                            return buildCampaignCard(
                              context, 
                              companyProfile!.result!.campaignList![index].campaingLogo!,
                              companyProfile!.result!.campaignList![index].campaingName!,
                            );
                          })
                        ]),
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

  Padding buildCampaignCard(BuildContext context, String campaignImage, String campaignLeading) {
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
                          image: NetworkImage(campaignImage)
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
                      campaignLeading, 
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
                            //-----------------------------ONAYLAMA ICONBUTTONI--------------------------------
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