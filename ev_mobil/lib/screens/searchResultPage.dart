import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/backleadingWidget.dart';
import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget {
  SearchResultPage({Key key}) : super(key: key);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  List homeContent = []; 
  int userIdData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BackGroundContainer(
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
                            image: AssetImage("assets/images/logo.png") //NetworkImage(""),
                           ),
                          ),
                          ),
                          Text("Ayna Ayna",style: TextStyle(color: white)),
                        ],
                      ),
                    ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Column(children: [
                    Text("Kampanya",style: TextStyle(color: white)),
                    Text("250",style: TextStyle(color: white)),
                  ]),
                  SizedBox(width: deviceWidth(context)*0.1),
                    Column(children: [
                    Text("Beğeni",style: TextStyle(color: white)),
                    Text("150",style: TextStyle(color: white)),
                  ]),
                  SizedBox(width: deviceWidth(context)*0.1),
                    Column(children: [
                    Text("Favori",style: TextStyle(color: white)),
                    Text("450",style: TextStyle(color: white)),
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
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(cardCurved)),
                  color: Theme.of(context).backgroundColor),
                  child: 
                  Column(children: [
                    //-----------------------------------------ŞİRKET BİLGİLERİ ---------------------------------------------
                    Padding(
                      padding:  EdgeInsets.only(left: deviceWidth(context)*0.1,top: deviceWidth(context)*0.03),
                      child: Row(children: [Text("Telefon"), SizedBox(width: deviceWidth(context)*0.05),Text("03326060235")]),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: deviceWidth(context)*0.1,top: deviceWidth(context)*0.03),
                      child: Row(children: [Text("WhatsApp"), SizedBox(width: deviceWidth(context)*0.05),Text("05332313188")]),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: deviceWidth(context)*0.1,top: deviceWidth(context)*0.03),
                      child: Row(children: [Text("Web Adresi"), SizedBox(width: deviceWidth(context)*0.05),Text("www.aynaayna.biz")]),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: deviceWidth(context)*0.1,top: deviceWidth(context)*0.03),
                      child: Row(children: [Text("E-Posta"), SizedBox(width: deviceWidth(context)*0.05),Text("info@aynaayna.biz")]),
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
                      itemCount: 16,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: (1 / .5),
                        crossAxisCount : 2,
                        mainAxisSpacing: minSpace,
                        crossAxisSpacing: minSpace,
                      ), 
                      itemBuilder:  (BuildContext context, int index){
                        return Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(cardCurved)),color: secondaryColor),
                          child: Image.asset("assets/images/logo.png"));
                      }),
                    ),
                  ]),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}