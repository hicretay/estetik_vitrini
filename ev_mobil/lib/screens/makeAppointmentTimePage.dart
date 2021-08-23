import 'package:estetikvitrini/screens/makeAppointmentCheckPage.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/textButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class MakeAppointmentTimePage extends StatefulWidget {
  final List companyOperationTime;
  MakeAppointmentTimePage({Key key, this.companyOperationTime}) : super(key: key);

  @override
  _MakeAppointmentTimePageState createState() => _MakeAppointmentTimePageState(companyOperationTime: companyOperationTime);
}

class _MakeAppointmentTimePageState extends State<MakeAppointmentTimePage> {
  List companyOperationTime;
  _MakeAppointmentTimePageState({this.companyOperationTime});

  List<String> gridChildren = [
    "08.00",
    "08.30",
    "09.00",
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
      child: ProgressHUD(
        child: Builder(builder: (context)=>
            Scaffold(
            body: 
                Container(
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          bottomNavigationBar: TextButtonWidget(
          buttonText: "Randevuyu Tamamla",
          onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeReservationPage()));
          },),
          ),
        ),
      ),
    );
  }
}