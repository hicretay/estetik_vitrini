import 'package:estetikvitrini/JsnClass/companyProfile.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/backleadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class CompanyProfilePage extends StatefulWidget {
  final CompanyProfileJsn companyProfile;
  CompanyProfilePage({Key key, this.companyProfile}) : super(key: key);

  @override
  _CompanyProfilePageState createState() => _CompanyProfilePageState(companyProfile: companyProfile);
}

class _CompanyProfilePageState extends State<CompanyProfilePage> {
  List homeContent = []; 
  int userIdData;
  CompanyProfileJsn companyProfile;

  _CompanyProfilePageState({this.companyProfile});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: Builder(builder: (context)=>
            BackGroundContainer(
            colors: backGroundColor1,
            child: Column(
              children: [
                BackLeadingWidget(backColor: primaryColor),
                Padding(
                  padding: const EdgeInsets.only(right: defaultPadding,left: defaultPadding),
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children:[
                              Container(
                                alignment: Alignment.topLeft,
                                width: deviceWidth(context)*0.2,
                                height: deviceWidth(context)*0.2,
                                decoration: BoxDecoration(
                                color: white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                image: NetworkImage(companyProfile.result.companyLogo ?? circularBasic)
                               ),
                              ),
                              ),
                              SizedBox(
                                width: deviceWidth(context)*0.3,
                                child: Center(
                                child: Text(companyProfile.result.companyName,
                                style: TextStyle(color: white),
                                overflow: TextOverflow.fade))),
                            ],
                          ),
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        Column(children: [
                        Text("Kampanya",style: TextStyle(color: white)),
                        Text(companyProfile.result.campaignCount.toString(),style: TextStyle(color: white)),
                      ]),
                      SizedBox(width: deviceWidth(context)*0.1),
                        Column(children: [
                        Text("Beğeni",style: TextStyle(color: white)),
                        Text(companyProfile.result.likeCount.toString(),style: TextStyle(color: white)),
                      ]),
                      SizedBox(width: deviceWidth(context)*0.1),
                        Column(children: [
                        Text("Favori",style: TextStyle(color: white)),
                        Text(companyProfile.result.favCount.toString(),style: TextStyle(color: white)),
                      ])
                       ],
                      )
                    ],
                  ),
                ),
                  
                SizedBox(height: deviceHeight(context)*0.01),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height: deviceHeight(context),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(cardCurved)),
                      color: Theme.of(context).backgroundColor),
                      child: 
                      Column(children: [
                        //-----------------------------------------ŞİRKET BİLGİLERİ ---------------------------------------------
                        Padding(
                          padding:  EdgeInsets.only(left: deviceWidth(context)*0.1,top: deviceWidth(context)*0.03),
                          child: Row(children: [Text("Telefon"), SizedBox(width: deviceWidth(context)*0.05),Text(companyProfile.result.companyPhone)]),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: deviceWidth(context)*0.1,top: deviceWidth(context)*0.03),
                          child: Row(children: [Text("WhatsApp"), SizedBox(width: deviceWidth(context)*0.05),Text(companyProfile.result.companyPhone2)]),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: deviceWidth(context)*0.1,top: deviceWidth(context)*0.03),
                          child: Row(children: [Text("Web Adresi"), SizedBox(width: deviceWidth(context)*0.05),Text(companyProfile.result.web)]),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: deviceWidth(context)*0.1,top: deviceWidth(context)*0.03),
                          child: Row(children: [Text("E-Posta"), SizedBox(width: deviceWidth(context)*0.05),Text(companyProfile.result.eMail)]),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: deviceWidth(context)*0.1,top: deviceWidth(context)*0.03),
                          child: Row(children: [Text("Konum"), SizedBox(width: deviceWidth(context)*0.05),Text("Haritalarda açmak için tıklayınız")]),
                        ),
                        SizedBox(height: deviceHeight(context)*0.01),
                        //----------------------------------------KAMPANYA LİSTESİ AKIŞI--------------------------------------------
                        Padding(
                          padding: const EdgeInsets.only(left: maxSpace,right: maxSpace),
                          child: GridView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,                 
                          itemCount: companyProfile.result.campaignList.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: (1 / .5),
                            crossAxisCount : 2,
                            mainAxisSpacing: minSpace,
                            crossAxisSpacing: minSpace,
                          ), 
                          itemBuilder:  (BuildContext context, int index){
                            return Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(cardCurved)),color: secondaryColor),
                              child: Image.network(companyProfile.result.campaignList[index].campaingLogo));
                          }),
                        ),
                      ]),
                    ),
                  ),
                )
              ],
            ),
                ),
          ),
        )),
    );
  }
}