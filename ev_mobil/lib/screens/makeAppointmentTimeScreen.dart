import 'package:ev_mobil/screens/makeReservationPage.dart';
import 'package:ev_mobil/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MakeAppointmentTimePage extends StatefulWidget {
  MakeAppointmentTimePage({Key key}) : super(key: key);

  @override
  _MakeAppointmentTimeScreenState createState() => _MakeAppointmentTimeScreenState();
}

class _MakeAppointmentTimeScreenState extends State<MakeAppointmentTimePage> {
  var gridChildren = [
     "08.00",
     "08.30",
     "9.00",
     "09.30",
     "10.00",
     "10.30",
     "11.00",
     "11.30",
     "12.00",
     "12.30",
     "13.00",
     "13.30",
     "14.00",
     "14.30",
     "15.00",
     "15.30",
     "16.00",
     "16.30",
     "17.00",
     "17.30",
  ];

  int _checked = 0;
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
                      Padding(
                      padding:  const EdgeInsets.only(top: defaultPadding*2),
                      child: Padding(padding: const EdgeInsets.all(defaultPadding),
                      child: GridView.builder(
                        shrinkWrap: true,                 
                        itemCount: gridChildren.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: (1 / .4),
                          crossAxisCount : 4,
                          mainAxisSpacing: minSpace,
                          crossAxisSpacing: minSpace,
                        ), 
                        itemBuilder:  (BuildContext context, int index){
                          return Container(
                          color: _checked==index ? secondaryColor : white,
                          child: TextButton(
                            child: Text(
                              gridChildren[index],
                              style: TextStyle(
                                color: primaryColor,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                //butona basıldığında değeri günceller
                                _checked = index;
                              });
                            },
                          ),
                        );
                        }),
                       ),
                      ),

                    TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeReservationPage()));
                      });
                      //Buton tıklandığında randevu al sayfasına yönlendirilecek
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //-------------Buton Metni-------------
                          Text(
                            "Randevuyu Tamamla",
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