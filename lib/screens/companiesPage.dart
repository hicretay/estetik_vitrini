import 'package:estetikvitrini/JsnClass/companyListJsn.dart';
import 'package:estetikvitrini/JsnClass/companyOperationJsn.dart';
import 'package:estetikvitrini/model/appointmentModel.dart';
import 'package:estetikvitrini/screens/makeAppointmentOperationPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/backleadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompaniesPage extends StatefulWidget {
  final String? date;
  CompaniesPage({Key? key, this.date}) : super(key: key);

 @override
  _CompaniesPageState createState() => _CompaniesPageState(date: date!);
}
class _CompaniesPageState extends State<CompaniesPage> {
  TextEditingController teSearch = TextEditingController();
  List allCompanies = [];
  List selectedCompanies = [];
  bool isFirstTime = true;
  String? date;

  _CompaniesPageState({this.date});

   Future<CompanyListJsn> allCompaniesList() async{
   final CompanyListJsn? companyNewList = await companyListJsnFunc(); 
   if(mounted)
   setState(() {
      allCompanies = companyNewList!.result!;
   });
   return companyNewList!;
   }

   @override
   void initState() { 
     super.initState();
     allCompaniesList();    
   }

 @override
 Widget build(BuildContext context) {
        return FutureBuilder<Object>(
          future: allCompaniesList(),
          builder: (context, snapshot) {
          if(snapshot.hasError){
          return Center(child: Text("HATA"));
          }else{
            if(snapshot.hasData){
              if(isFirstTime){
              selectedCompanies = allCompanies;
              isFirstTime=false;
              }
            return SafeArea(
            child: Scaffold(
            body: ProgressHUD(
            child: Builder(builder: (context)=>
                  BackGroundContainer(
                  child: Column(
                  children: [
                    BackLeadingWidget(
                      backColor: primaryColor,
                    ),
                      Padding(padding: const EdgeInsets.only(left: maxSpace),
                          child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("firmalar", 
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: white, fontFamily: leadingFont),
                                ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("randevu alınacak firmayı seçiniz",  
                              style: TextStyle(color: Colors.white),
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
                          child: Padding(
                            padding: const EdgeInsets.only(top: maxSpace),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListTile(
                                  title: TextField(
                                    cursorColor: primaryColor,
                                  controller: teSearch,
                                  decoration: InputDecoration(
                                    hintText: "Ara",
                                    hintStyle: TextStyle(color: primaryColor),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.all(maxSpace),
                                    filled: true,
                                    fillColor: white,
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
                                    ListView.separated(
                                    padding: EdgeInsets.all(0),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: selectedCompanies.length == 0 ? allCompanies.length : selectedCompanies.length, 
                                    itemBuilder: (BuildContext context, int index) {
                                      return Padding(padding: const EdgeInsets.only(left: defaultPadding,right: defaultPadding), 
                                          child: InkWell(
                                            child: Container(
                                              height: deviceHeight(context) * 0.06,
                                              width: deviceWidth(context) * 0.06,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(15)),color: darkWhite,
                                              ),
                                              child: Center(
                                                child: Text(selectedCompanies.length == 0 ? allCompanies[index].companyName : selectedCompanies[index].companyName,  
                                                textAlign: TextAlign.center,
                                                style    : TextStyle(
                                                fontSize : 18, 
                                                color: primaryColor
                                                ),
                                                ),
                                              ),
                                            ),
                                            onTap: ()async{
                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                              int? userIdData = prefs.getInt("userIdData"); 
                                              if(userIdData != 0){
                                              AppointmentObject appointment = AppointmentObject(companyId: selectedCompanies.length == 0 ? allCompanies[index].id : selectedCompanies[index].id,userId: userIdData!, companyNameS: selectedCompanies.length == 0 ? allCompanies[index].companyName : selectedCompanies[index].companyName, campaignId: 0, appointmentDate: date!);
                                              final CompanyOperationJsn? companyOperation = await companyOperationJsnFunc(appointment.companyId!);
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeAppointmentOperationPage(companyOperation: companyOperation!.result, appointment: appointment)));
                                              print(selectedCompanies.length == 0 ? allCompanies[index].companyName : selectedCompanies[index].companyName);
                                              print(selectedCompanies.length == 0 ? allCompanies[index].id : selectedCompanies[index].id);
                                            }},
                                          ),
                                      );
                                    },
                                    separatorBuilder: (BuildContext context, int index) {
                                      return SizedBox(height: minSpace);
                                    },
                                    ),
                                    SizedBox(height: maxSpace)
                                  ],
                              ),
                            ),
                          )
                        ),
                      ),
                    ],
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
        );
  }
}