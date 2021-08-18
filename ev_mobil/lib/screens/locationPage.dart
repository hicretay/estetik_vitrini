import 'package:estetikvitrini/JsnClass/cityJsn.dart';
import 'package:estetikvitrini/JsnClass/countyJsn.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:estetikvitrini/settings/functions.dart';


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

   Future cityList() async{
   final CityJsn cityNewList = await cityJsnFunc(); 
   setState(() {
      cities = cityNewList.result;
   });
 }
   
   Future countyList() async{
   final CountyJsn countiesNewList = await countyJsnFunc(selection ==null ? "İSTANBUL" : selection); 
   setState(() {
      counties = countiesNewList.result;
   });
 }

 @override
 void initState() { 
   super.initState();
   setState(() {
   cityList();
   countyList();
  });
 }

 //---------silinecek------------
  // Map<String, bool> _location = {
  //   "Fatih": false,
  //   "Maltepe": false,
  //   "Üsküdar": true,
  //   "Sarıyer": false,
  //   "Beşiktaş": false,
  //   "Kartal": false,
  // };
  //------------------------------

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body  : ProgressHUD(
        child: Builder(builder: (context)=>
          BackGroundContainer(
          colors: backGroundColor1,
          child : Column(
              children: [
                Padding(padding: const EdgeInsets.all(defaultPadding),
                  //--------------Scaffold Görünümlü header--------------
                child: Padding(
                  padding: const EdgeInsets.only(left: defaultPadding,right: defaultPadding,top: defaultPadding),
                  child: Column(
                    children: [
                      Align(alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Favori\nBölgeler", //Büyük Başlık
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(color: white, fontFamily: leadingFont),
                              maxLines: 2,
                            ),
                            Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                            //iconun çevresini saran yapı tasarımı
                            maxRadius: 25,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              iconSize: iconSize,
                              icon: SvgPicture.asset("assets/icons/haritanoktası.svg"),
                              onPressed:(){},
                            ),
                          ),)
                          
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
                  child: Padding(padding: const EdgeInsets.only(top: defaultPadding),
                  child: Container(
                    // arkaplan containerı
                    decoration: BoxDecoration(
                      color: lightWhite,
                      borderRadius: BorderRadius.vertical( top: Radius.circular(maxSpace)),
                        //dikeyde yuvarlatılmış
                    ),
                    //-----------------------Itamların Listelenmesi----------------------------
                    child: ListView(
                      children: [
                      SizedBox(height: defaultPadding),
                      Center(
                          child: Container(
                          height: deviceHeight(context)*0.08,
                          width: deviceWidth(context)*0.9,
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)),color: darkWhite,
                          gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                    colors: backGroundColor1
                                  ),),
                            child: ListTile(leading: SvgPicture.asset("assets/icons/haritanoktası.svg",color: secondaryColor,height: deviceHeight(context)*0.04),
                            title: Center(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(   
                                hint: Text("il seçiniz"),
                                dropdownColor: Colors.transparent,
                                value: selection,
                                items: cities.map((data){
                                  return DropdownMenuItem(
                                  child: SizedBox(
                                    width: deviceWidth(context)*0.45,
                                    child: Center(
                                      child: Text(data.city, textAlign: TextAlign.center,
                                      style: TextStyle(color: white, fontSize: 20)),
                                    ),
                                  ),
                                  value: data.city);
                                }).toList(),                                  
                                onChanged: (value) {
                                 setState(() {
                                   selection = value;
                                 });
                                 },
                                 onTap: (){
                                    
                                 },
                             ),
                            ),
     
                            ),
                            trailing: SvgPicture.asset("assets/icons/haritanoktası.svg",color: Colors.transparent,height: deviceHeight(context)*0.05)
                            ),
                        ),
                      ),
                      SizedBox(height: deviceHeight(context)*0.02),
                      //Text("$selection"),
                      //Text("---------------------"),
                      // ListView.builder(
                      //   itemCount: counties.length,
                      //   shrinkWrap: true,
                      //   itemBuilder: (context, index){
                      //   return Text(counties[index].county);
                      // })
                      //selection != null?
                      FutureBuilder(
                        future: countyList(),
                        builder: (context,snapshot){                        
                          return 
                          ListView.builder(
                            itemCount: counties.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index){
                              //var list = snapshot.data[index];
                              return Text(counties[index].county);
                          });
                          }

                          //return Text("no data found");
                        
                      )
                      //Text("select item"),


                      // ListView.separated(
                      // physics: BouncingScrollPhysics(),
                      // scrollDirection: Axis.vertical, //dikeyde kaydırılabilir
                      // shrinkWrap: true,
                      // itemCount: _location.length, //_location mapi uzunluğu kadar
                      // itemBuilder: (BuildContext context, int index) {
                      //   return Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), // yalnızca sol ve sağdan boşluk
                      //       //InkWell sarmaladığı widgeta tıklanabilirlik özelliği kazandırdı
                      //       //InkWell ile liste yapısının tamamı tıklanabilir hale geldi
                      //       child: InkWell(
                      //         onTap: () {
                      //           setState(() {
                      //             //_location mapinin keyleri listeye çevrildi ve tıklandığında true olarak güncellendi
                      //             _location.update(_location.keys.toList()[index],
                      //                 (value) => !value);
                      //           });
                      //         },
                      //         child: Container(
                      //           //locationların listeleneceği card genişliği
                      //           height: deviceHeight(context) * 0.08,
                      //           width: deviceWidth(context) * 0.9,
                      //           decoration: BoxDecoration(
                      //             // Container rengi gradient ile verildi
                      //             borderRadius: BorderRadius.all(Radius.circular(15)),color: darkWhite,
                      //             gradient: LinearGradient(
                      //               //soldan sağa doğru color listteki renkleri yaydı
                      //               begin: Alignment.topLeft,
                      //               end: Alignment.topRight,
                      //               //_location mapinin value(true - false) değerlerinin indexine göre rengi kontrol ediyor
                      //               colors: _location.values.toList()[index]
                      //                   ? backGroundColor1 // true ise(seçili) ise renk koyu
                      //                   : backGroundColor3, // false ise seçilmemişse açık
                      //             ),
                      //           ),
                      //           child: Center(
                      //             //Bir seçim radiosu ve text yapısından oluşan listTile
                      //             child: ListTile(
                      //               //İç container yapısı
                      //               leading: Container(
                      //               width  : deviceWidth(context)*0.065,
                      //               height : deviceHeight(context)*0.065,
                      //               decoration: BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               gradient: LinearGradient(
                      //               begin: Alignment.topLeft,
                      //               end: Alignment.topRight,
                      //                     //_location mapinin valuelarının index değerine göre renk belirler
                      //                     colors: _location.values.toList()[index]
                      //                         ? backGroundColor1 // true ise(seçili) ise renk koyu
                      //                         : backGroundColor3, // false ise seçilmemişse açık
                      //                   ),
                      //                 ),
                      //                 //Dış container yapısı
                      //                 child: Container(
                      //                   decoration: BoxDecoration(
                      //                     shape: BoxShape.circle,
                      //                     border: Border.all(
                      //                         color: lightWhite,
                      //                         width: 4.5 ),// mor dairenin genişliği
                      //                   ),
                      //                 ),
                      //               ),
                      //               //_location isimlerinin gösterildiği text
                      //               title: Text(_location.keys.toList()[index], //_location mapinin keylerinin indexine göre ekrana yazar
                      //                 textAlign: TextAlign.center,
                      //                 style    : TextStyle(
                      //                 fontSize : 22, // ilçelerin fontu
                      //                 color: _location.values.toList()[index]
                      //                       ? Colors.white // seçili ise açık text
                      //                       : primaryColor, // seçili değilse koyu
                      //                 ),
                      //               ),
                      //               trailing: Icon(Icons.location_city,color: Colors.transparent) //SvgPicture.asset("assets/icons/haritanoktası.svg"),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //   );
                      // },
                      // //separatorBuilder list itemları arasına bir widget koymayı sağlıyor
                      // //SizedBox ile itemlar arası boşluk sağlandı
                      // separatorBuilder: (BuildContext context, int index) {
                      //   return SizedBox(height: minSpace);
                      // },
                      // ),
                    ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: TextButtonWidget(
        buttonText: "Uygula",
        onPressed: (){
          //NavigationProvider.of(context).setTab(HOME_PAGE);            
        }),
   ),
    );
  }
}

// class City extends Equatable {
//   final String id;
//   final String city;

//   City(this.city, this.id);
   
//   @override
//   List<Object> get props => [id];
// }

class Language {
  final String id;
  final String city;

  const Language(this.city, this.id);

  int get hashCode => id.hashCode;

  bool operator==(Object other) => other is Language && other.id == id;
}