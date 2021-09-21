import 'package:estetikvitrini/JsnClass/cityJsn.dart';
import 'package:estetikvitrini/JsnClass/countyJsn.dart';
import 'package:estetikvitrini/providers/navigationProvider.dart';
import 'package:estetikvitrini/providers/themeDataProvider.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:provider/provider.dart';
import '../settings/consts.dart';

class LocationPage extends StatefulWidget{
  static const route = "locationPage";
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {

  String selection;
  
  List cities = [];
  List counties = [];
  List checkedCounty = [];
  Map<dynamic,bool> countyMap = {};
  int userIdData;

   Future cityList() async{
   final CityJsn cityNewList = await cityJsnFunc(); 
   if (!mounted)
   return;
   setState(() {
      cities = cityNewList.result;
   });
 }
   
   Future countyList() async{
   final CountyJsn countiesNewList = await countyJsnFunc(selection ==null ? "İSTANBUL" : selection); 
   if (!mounted)
   return;
   setState(() {     
      counties = countiesNewList.result;
      for (var temp in counties) {
        Map<dynamic,bool> newItem = {temp:false};
        countyMap.addEntries(newItem.entries);
      }
   });
 }

 @override
 void initState() { 
   super.initState();
   if (!mounted)
   return;
   setState(() {
   cityList();
   countyList();
  });
 }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        child: Scaffold(
        body  : ProgressHUD(
          child: Builder(builder: (context)=>
            BackGroundContainer(
            colors: Provider.of<ThemeDataProvider>(context, listen: true).isLightTheme ? backGroundColor1 : backGroundColorDark,
            child : Column(
                children: [
                  Padding(padding: const EdgeInsets.all(defaultPadding),
                    //--------------Scaffold Görünümlü header--------------
                  child: Padding(
                    padding: const EdgeInsets.only(left: defaultPadding,right: defaultPadding,top: defaultPadding*2),
                    child: Column(
                      children: [
                        Align(alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Favori\nBölgeler", //Büyük Başlık
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(color: white, fontFamily: leadingFont),
                                maxLines: 2,
                              ),
                            //   Align(
                            //   alignment: Alignment.topRight,
                            //   child: CircleAvatar(
                            //   //iconun çevresini saran yapı tasarımı
                            //   maxRadius: 20,
                            //   backgroundColor: Colors.white,
                            //   child: IconButton(
                            //     iconSize: iconSize,
                            //     icon: SvgPicture.asset("assets/icons/haritanoktası.svg"),
                            //     onPressed:(){},
                            //   ),
                            // ),)
                            ],
                          ),
                        ),
                        Align(alignment: Alignment.bottomLeft,
                          child: Text("Lütfen en az bir tane bölge seçiniz.", // Alt Başlık
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: white),
                          ),
                        ),
                      ],
                    ),
                  ),
                    //---------------------------------------------------
                  ),
                  Expanded(
                    child: Container(
                      // arkaplan containerı
                      decoration: BoxDecoration(
                        color: Provider.of<ThemeDataProvider>(context, listen: true).isLightTheme ? lightWhite : darkBg,
                        borderRadius: BorderRadius.vertical( top: Radius.circular(maxSpace)),
                          //dikeyde yuvarlatılmış
                      ),
                      //-----------------------Itamların Listelenmesi----------------------------
                      child: ListView(
                        children: [
                        SizedBox(height: defaultPadding),
                        Center(
                            child: Container(
                            height: deviceHeight(context)*0.07,
                            width: deviceWidth(context)*0.9,
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)),color: darkWhite,
                            gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.topRight,
                                      colors: backGroundColor1
                                    ),),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                SizedBox(width: deviceWidth(context)*0.06),
                                SvgPicture.asset("assets/icons/haritanoktası.svg",color: secondaryColor,height: deviceHeight(context)*0.035),
                                Flexible(
                                  child: Center(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(   
                                      isExpanded: true,
                                      hint: Center(
                                        child: Text("İSTANBUL",
                                        textAlign: TextAlign.center,
                                              style    : TextStyle(
                                              fontSize : 20, // ilçelerin fontu
                                              color:  Colors.white,
                                              ),),
                                      ),
                                      dropdownColor: Colors.transparent,
                                      value: selection,
                                      items: cities.map((data){
                                        return DropdownMenuItem(
                                        child: SizedBox(
                                          child: Center(
                                            child: Text(data.city, textAlign: TextAlign.center,
                                            style: TextStyle(color: white, fontSize: 20)),
                                          ),
                                        ),
                                        value: data.city);
                                      }).toList(),                                  
                                      onChanged: (value) {
                                           if (!mounted)
                                           return;                                  
                                       setState(() {
                                         countyMap.clear();
                                         counties.clear();
                                         selection = value;
                                       });
                                       },
                               ),
                              ),
                                  ),
                                ),
                              SizedBox(width: deviceWidth(context)*0.06),
                                ],

                              ),
                          ),
                        ),
                        SizedBox(height: deviceHeight(context)*0.02),
                        FutureBuilder(
                        future: countyList(),
                        builder: (context,snapshot){                                            
                        return  counties.isNotEmpty ? 
                        ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical, //dikeyde kaydırılabilir
                        shrinkWrap: true,
                        itemCount: counties.length, //_location mapi uzunluğu kadar
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), // yalnızca sol ve sağdan boşluk
                              //InkWell sarmaladığı widgeta tıklanabilirlik özelliği kazandırdı
                              //InkWell ile liste yapısının tamamı tıklanabilir hale geldi
                              child: InkWell(
                                onTap: () {
                                     if (!mounted)
                                     return;
                                  setState(() {
                                    //_location mapinin keyleri listeye çevrildi ve tıklandığında true olarak güncellendi
                                    countyMap.update(countyMap.keys.toList()[index],
                                        (value) => !value);
                                  });
                                },
                                child: Container(
                                  //locationların listeleneceği card genişliği
                                  height: deviceHeight(context) * 0.06,
                                  width: deviceWidth(context) * 0.06,
                                  decoration: BoxDecoration(
                                    // Container rengi gradient ile verildi
                                    borderRadius: BorderRadius.all(Radius.circular(15)),color: darkWhite,
                                    gradient: LinearGradient(
                                      //soldan sağa doğru color listteki renkleri yaydı
                                      begin: Alignment.topLeft,
                                      end: Alignment.topRight,
                                      //countyMap mapinin value(true - false) değerlerinin indexine göre rengi kontrol ediyor
                                      colors: 
                                      countyMap.values.toList()[index]
                                          ? backGroundColor1 // true ise(seçili) ise renk koyu
                                          : backGroundColor3, // false ise seçilmemişse açık
                                    ),
                                  ),
                                  child: Center(
                                    //Bir seçim radiosu ve text yapısından oluşan listTile
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      //İç container yapısı
                                      children: [
                                      SizedBox(width: deviceWidth(context)*0.04),
                                      Container(
                                      width  : deviceWidth(context)*0.06,
                                      height : deviceHeight(context)*0.06,
                                      decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.topRight,
                                            //countyMap mapinin valuelarının index değerine göre renk belirler
                                            colors: 
                                               countyMap.values.toList()[index]
                                               ? backGroundColor1 // true ise(seçili) ise renk koyu
                                               : backGroundColor3, // false ise seçilmemişse açık
                                          ),
                                        ),
                                        //Dış container yapısı
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: lightWhite,
                                                width: 4.5 ),// mor dairenin genişliği
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: deviceWidth(context)*0.2),
                                      //countyMap isimlerinin gösterildiği text
                                        Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                          children: 
                                            [Text( counties[index].county,   //countyMap mapinin keylerinin indexine göre ekrana yazar
                                            textAlign: TextAlign.center,
                                            style    : TextStyle(
                                            fontSize : 18, // ilçelerin fontu
                                            color: countyMap.values.toList()[index]
                                                   ? Colors.white // seçili ise açık text
                                                   : primaryColor, // seçili değilse koyu
                                            ),
                                      ),
                                          ],
                                        ),
                                       Icon(Icons.location_city,color: Colors.transparent) //SvgPicture.asset("assets/icons/haritanoktası.svg"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          );
                        },
                        //separatorBuilder list itemları arasına bir widget koymayı sağlıyor
                        //SizedBox ile itemlar arası boşluk sağlandı
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: minSpace);
                        },
                        ): Center(child: circularBasic);
                       }),                
                      ],
                      ),
                    ))
                ],
              ),
            ),
          ),
        ),
          bottomNavigationBar: Container(
            color: Theme.of(context).backgroundColor,
            child: TextButtonWidget(
            buttonText: "Uygula",
            onPressed: ()async{
              //AddUserCity servisini al
              // SharedPreferences prefs = await SharedPreferences.getInstance();
              // userIdData = prefs.getInt("userIdData"); 
              //final userCityAdd = await userAddCityJsnFunc(userIdData, 1,1);
              // if(userCityAdd.success == true){
              await showToast(context, "Seçmiş olduğunuz bölgelere akış başarıyla uygulandı");
              NavigationProvider.of(context).setTab(HOME_PAGE);
              //}
              //else{
                await showToast(context, "Seçmiş olduğunuz bölgeler daha önce seçilmiş!");
              //}
              for (var i = 0; i < counties.length; i++) {
                if (countyMap.values.toList()[i]) {
                  checkedCounty.add(countyMap.keys.toList()[i]);
                }
              }
              for (var item in checkedCounty) {
                print(item.id);
                print(item.county);
              }
            }),
          ),
        ),
      ),
    );
  }
}
