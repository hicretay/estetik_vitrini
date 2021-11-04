import 'package:estetikvitrini/JsnClass/companyListJsn.dart';
import 'package:estetikvitrini/JsnClass/companyProfile.dart';
import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:estetikvitrini/providers/themeDataProvider.dart';
import 'package:estetikvitrini/screens/companyProfilePage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
   static const route = "searchPage";
  SearchPage({Key key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController teSearch = TextEditingController();
  List allCompanies = [];
  List selectedCompanies = [];
  bool isFirstTime = true;
  FocusNode nodeFirst = FocusNode();

   Future<CompanyListJsn> allCompaniesList() async{
   final CompanyListJsn companyNewList = await companyListJsnFunc(); 
   setState(() {
      allCompanies = companyNewList.result;
   });
   return companyNewList;
   }

   @override
   void initState() { 
     super.initState();
     allCompaniesList();    
   }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CompanyListJsn>(
      future: allCompaniesList(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Center(child: Text("HATA"),);
          }else{
            if(snapshot.hasData){
              if(isFirstTime){
              selectedCompanies = allCompanies;
              isFirstTime=false;
              }
        return Container(
          color: Colors.transparent,
          child: SafeArea(
            top: false, 
            child: Scaffold(
              body: ProgressHUD(
                child: Builder(builder: (context)=>
                  Container(
                  color:  Provider.of<ThemeDataProvider>(context, listen: true).isLightTheme ?  secondaryColor: darkBg,
                  child: Padding(
                    padding: EdgeInsets.only(top: deviceHeight(context)*0.03),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(maxSpace),
                          child: Container(
                             decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(25)),
                               child: Row(
                                 children: [
                                  CircleAvatar(
                                  //iconun çevresini saran yapı tasarımı
                                  maxRadius: 25,
                                  backgroundColor: Colors.transparent,
                                  child: IconButton(
                                    iconSize: iconSize,
                                    icon: Icon(Icons.arrow_back,color: primaryColor,size: 30),
                                    onPressed: (){
                                      NavigationProvider.of(context).setTab(HOME_PAGE);
                                    },
                                  ),
                                ),
                                 Flexible(
                                   child: ListTile(
                                   title: TextField(
                                   controller: teSearch,
                                   decoration: InputDecoration(
                                     hintText: "Ara",
                                     hintStyle: TextStyle(color: primaryColor),
                                     focusedBorder: InputBorder.none,
                                     enabledBorder: InputBorder.none,
                                     contentPadding: EdgeInsets.all(maxSpace),
                                     filled: true,
                                     fillColor: Colors.white,
                                     border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(cardCurved),
                                     ),
                                   ),
                                   onTap: (){
                                    selectedCompanies.clear();
                                     setState(() {
                                    allCompanies.forEach((element) {
                                    if(element.companyName.toLowerCase().contains(teSearch.text.toLowerCase())){
                                      selectedCompanies.add(element);
                                    }
                                    });
                                   });
                                   },
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
                                ],
                               ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: defaultPadding,left: defaultPadding, bottom: defaultPadding/2),
                            child: Container(
                              decoration: BoxDecoration(color: lightWhite,borderRadius: BorderRadius.all(Radius.circular(20))),
                              child: ListView.separated(
                                padding: EdgeInsets.all(0),
                                controller: NavigationProvider.of(context).screens[SEARCH_PAGE].scrollController, 
                                shrinkWrap: true,
                                itemCount: selectedCompanies.length == 0 ? allCompanies.length : selectedCompanies.length,
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
                                  image: NetworkImage(selectedCompanies.length == 0 ?
                                  allCompanies[index].companyLogo : selectedCompanies[index].companyLogo,
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
                                  selectedCompanies.length == 0 ?
                                  allCompanies[index].companyName : selectedCompanies[index].companyName,
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
                      onTap: ()async{
                        final progressUHD = ProgressHUD.of(context);
                        progressUHD.show();
                        final CompanyProfileJsn companyProfile = await companyListDetailJsnFunc(selectedCompanies[index].id);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> CompanyProfilePage(companyProfile: companyProfile)));
                        progressUHD.dismiss();
                      },
                      );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 0,
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
                  ),
                  ),
                ),
              ),
          ),
          ),
        );
        }else{
          return circularBasic;
        }
          }
      }
    );}
}