import 'package:ev_mobil/settings/navigationProvider.dart';
import 'package:ev_mobil/settings/consts.dart';
import 'package:ev_mobil/widgets/headerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'informationRowWidget.dart';

class MakeReservationWidget extends StatefulWidget {

  MakeReservationWidget({Key key}) : super(key: key);

  @override
  _MakeReservationWidgetState createState() => _MakeReservationWidgetState();
}

class _MakeReservationWidgetState extends State<MakeReservationWidget> {
  TextEditingController teName = TextEditingController();
  TextEditingController teNote = TextEditingController();
  String teOperation;

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
                child: HeaderWidget(
                  primaryIcon: Icon(
                    Icons.arrow_back,
                    color: secondaryColor,
                  ),
                  secondaryIcon: Icon(
                    Icons.search,
                    color: secondaryColor,
                  ),
                  onPressedSecondary: () {},
                  onPressedPrimary: () {
                    Navigator.pop(context, false);
                  },
                ),
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
                    child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              InformationRowWidget(
                containerColor: secondaryColor,
                operationName: "Tarih",
                width: 250,
                height: 50,
                child: Text("20 Mayıs 2021",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InformationRowWidget(
                containerColor: secondaryColor,
                width: 250,
                height: 50,
                operationName: "Saat",
                child: Text(
                  "16.30",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              InformationRowWidget(
                containerColor: darkWhite,
                width: 250,
                height: 50,
                operationName: "Ad Soyad",
                child: TextField(
                  controller: teName,
                  cursorColor: primaryColor,
                  style: TextStyle(color: primaryColor, fontSize: 18),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              InformationRowWidget(
                containerColor: darkWhite,
                operationName: "İşlem",
                width: 250,
                height: 50,
                child: DropdownButton(
                  hint: Text(
                    "İşlem seçiniz:",
                    style: TextStyle(color: primaryColor, fontSize: 18),
                  ),
                  value: teOperation,
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        "Cilt Bakımı",
                        style: TextStyle(color: primaryColor, fontSize: 18),
                      ),
                      value: "Cilt Bakımı",
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "Lazer Epilasyon",
                        style: TextStyle(color: primaryColor, fontSize: 18),
                      ),
                      value: "Lazer Epilasyon",
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "Medikal Estetik",
                        style: TextStyle(color: primaryColor, fontSize: 18),
                      ),
                      value: "Medikal Estetik",
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      teOperation = value;
                    });
                  },
                ),
              ),
              InformationRowWidget(
                containerColor: darkWhite,
                width: 250,
                height: 100,
                operationName: "Özel Not",
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  controller: teNote,
                  cursorColor: primaryColor,
                  style: TextStyle(color: primaryColor, fontSize: 18),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(""),
                  Container(
                    width: 250,
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: backGroundColor1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: Center(
                      child: MaterialButton(
                        child: Text(
                          "Randevu Olustur",
                          style: TextStyle(
                              fontFamily: leadingFont,
                              color: Colors.white,
                              fontSize: 22),
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                            NavigationProvider.of(context).setTab(RESERVATION_PAGE);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
                  ),
                ),
              ),
            ],
          ),
        ),
    ));
  }
}


