import 'package:ev_mobil/screens/makeAppointmentTimeScreen.dart';
import 'package:ev_mobil/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MakeAppointmentOperationPage extends StatefulWidget {
  MakeAppointmentOperationPage({Key key}) : super(key: key);

  @override
  _MakeAppointmentOperationPageState createState() => _MakeAppointmentOperationPageState();
}

class _MakeAppointmentOperationPageState extends State<MakeAppointmentOperationPage> {
    Map<String, bool> _operations = {
    "Cilt Bakımı": false,
    "Medikal Estetik": false,
    "Lazer Epilasyon": false,
  };
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: secondaryColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  children: [
                    CircleAvatar(
                      //iconun çevresini saran yapı tasarımı
                      maxRadius: 25,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        iconSize: iconSize,
                        icon: Icon(Icons.arrow_back,color: secondaryColor,size: 25),
                        onPressed: (){Navigator.pop(context, false);},
                      ),
                    ),
                    SizedBox(
                      width: maxSpace,
                    ),
                    Text(
                      "Estetik Vitrini",
                      style: TextStyle(
                          fontFamily: leadingFont, fontSize: 25, color: Colors.white),
                    ),
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Randevu Al",
                        style: TextStyle(
                          fontFamily: leadingFont,
                          color: Colors.white,
                          fontSize: 45,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Estecool Güzellik Merkezi",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: maxSpace,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(cardCurved),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                    SizedBox(height: defaultPadding),
                    ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical, //dikeyde kaydırılabilir
                    shrinkWrap: true,
                    itemCount: _operations.length, //_location mapi uzunluğu kadar
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), // yalnızca sol ve sağdan boşluk
                          //InkWell sarmaladığı widgeta tıklanabilirlik özelliği kazandırdı
                          //InkWell ile liste yapısının tamamı tıklanabilir hale geldi
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                //_location mapinin keyleri listeye çevrildi ve tıklandığında true olarak güncellendi
                                _operations.update(_operations.keys.toList()[index],
                                    (value) => !value);
                              });
                            },
                            child: Container(
                              //locationların listeleneceği card genişliği
                              height: deviceHeight(context) * 0.08,
                              width: deviceWidth(context) * 0.9,
                              decoration: BoxDecoration(
                                // Container rengi gradient ile verildi
                                borderRadius: BorderRadius.all(Radius.circular(15)),color: darkWhite,
                                gradient: LinearGradient(
                                  //soldan sağa doğru color listteki renkleri yaydı
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                  //_operation mapinin value(true - false) değerlerinin indexine göre rengi kontrol ediyor
                                  colors: _operations.values.toList()[index]
                                      ? backGroundColor1 // true ise(seçili) ise renk koyu
                                      : backGroundColor3, // false ise seçilmemişse açık
                                ),
                              ),
                              child: Center(
                                //Bir seçim radiosu ve text yapısından oluşan listTile
                                child: ListTile(
                                  //İç container yapısı
                                  leading: Container(
                                  width  : deviceWidth(context)*0.07,
                                  height : deviceHeight(context)*0.07,
                                  decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                        //_operation mapinin valuelarının index değerine göre renk belirler
                                        colors: _operations.values.toList()[index]
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
                                  //_location isimlerinin gösterildiği text
                                  title: Text(_operations.keys.toList()[index], //_location mapinin keylerinin indexine göre ekrana yazar
                                    textAlign: TextAlign.center,
                                    style    : TextStyle(
                                    fontSize : 20, // işlemlerin fontu
                                    color: _operations.values.toList()[index]
                                          ? Colors.white // seçili ise açık text
                                          : primaryColor, // seçili değilse koyu
                                    ),
                                  ),
                                  trailing: Icon(Icons.location_city,color: Colors.transparent) //SvgPicture.asset("assets/icons/haritanoktası.svg"),
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
                    ),
                      TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeAppointmentTimePage()));
                      });
                      //Buton tıklandığında randevu al sayfasına yönlendirilecek
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //-------------Buton Metni-------------
                          Text(
                            "Randevu Saatini Seç",
                            style: Theme.of(context).textTheme.button.copyWith(color: primaryColor,fontSize: 18),
                          ),
                          //-------------------------------------
                          SizedBox(width: deviceWidth(context)*0.02), //butondaki Text ve icon arası boşluk
                          FaIcon(FontAwesomeIcons.arrowRight,size: 18,color: secondaryColor)
                        ],
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
    );
  }
}



