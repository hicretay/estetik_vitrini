import 'package:estetikvitrini/JsnClass/companyListJsn.dart';
import 'package:estetikvitrini/screens/searchResultPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController teSearch = TextEditingController();
  List allCompanies = [];
  List selectedCompanies = [];

   Future allCompaniesList() async{
   final CompanyListJsn companyNewList = await companyListJsnFunc(); 
   setState(() {
      allCompanies = companyNewList.result;
   });
   }

   @override
   void initState() { 
     super.initState();
     allCompaniesList();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
        color: secondaryColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Container(
                 decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(25)),
                   child: ListTile(
                   title: TextField(
                   autofocus: true,
                   controller: teSearch,
                   decoration: InputDecoration(
                     hintText: "Ara",
                     focusedBorder: InputBorder.none,
                     enabledBorder: InputBorder.none,
                     contentPadding: EdgeInsets.all(maxSpace),
                     filled: true,
                     fillColor: Colors.white,
                     border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(cardCurved),
                     ),
                   ),
                   onChanged: (value){
                    selectedCompanies.clear();
                    setState(() {
                    allCompanies.forEach((element) {
                    if(element.companyName.toLowerCase().contains(teSearch.text.toLowerCase())){
                      selectedCompanies.add(element);
                    }
                  });
                 });
                   },
                 ),
               trailing: IconButton(
               icon: FaIcon(FontAwesomeIcons.search,
               color: Theme.of(context).hintColor,size: 20,
               textDirection: TextDirection.ltr),
               onPressed: (){
                 selectedCompanies.clear();
                 setState(() {
                    allCompanies.forEach((element) {
                    if(element.companyName.toLowerCase().contains(teSearch.text.toLowerCase())){
                      selectedCompanies.add(element);
                    }
                  });
                 });
               }),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: defaultPadding,left: defaultPadding, bottom: defaultPadding),
                child: Container(
                  //height: deviceHeight(context)*0.105*selectedCompanies.length,
                  decoration: BoxDecoration(color: lightWhite,borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: ListView.separated(
                    itemCount: selectedCompanies.length,
                    itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(left: defaultPadding,right: defaultPadding),
                        child: Container(
                          height: deviceHeight(context)*0.1,
                          decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Row içindeki widgetların yayılmasını sağlar
                          children: [
                   Row( children: [
            //------------Başlıktaki firma logosu görünümü-----------
            SizedBox(width: deviceWidth(context)*0.01), 
            Container(
                  child: Container(
                      alignment: Alignment.topLeft,
                      width: deviceWidth(context)*0.15,
                      height: deviceWidth(context)*0.15,
                      decoration: BoxDecoration(
                      color: white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                      image: NetworkImage(
                       selectedCompanies[index].companyLogo,
                      ),
                   ),
                  ),
                  ),
            ),
            //-----------------------------------------------------
            SizedBox(width: deviceWidth(context)*0.03), //başlık iconu - texti arası boşluk

            SizedBox(
                  width: deviceWidth(context)*0.63,
                  child: Text(
                      selectedCompanies[index].companyName,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(fontSize: 17, fontFamily: headerFont,color: primaryColor)
                  ),
            ),
          ],
        ),
       SizedBox(width: deviceWidth(context)*0.01),      
      ],
    ))),
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchResultPage()));
    },
    );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: minSpace,
              child: Padding(
                padding: const EdgeInsets.only(right: defaultPadding*3,left: defaultPadding*2),
                child: Divider(
                  color: Colors.black12,
                  thickness: 1.5),
              ));
             },
            ),
           ),
         ),
        )
      ],
    ),
  )),
);}
}