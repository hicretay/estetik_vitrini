import 'package:ev_mobil/widgets/backgroundContainer.dart';
import 'package:ev_mobil/widgets/headerWidget.dart';
import 'package:flutter/material.dart';

import '../settings/consts.dart';

class LocationPage extends StatefulWidget {
    static const route = "locationPage";
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  //Sayfada gösterilecek konumlar mapi
  //String ile konum adı, bool ile seçili olup olmadığı tutulacak
  Map<String, bool> _location = {
    "Fatih": false,
    "Maltepe": false,
    "Üsküdar": true,
    "Sarıyer": false,
    "Beşiktaş": false,
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BackGroundContainer(
          colors: backGroundColor1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                //--------------Scaffold Görünümlü header--------------
                child: HeaderWidget(
                  primaryIcon: Icon(
                    // solda yer alan icon: arama
                    Icons.search,
                    color: primaryColor,
                  ),
                  onPressedPrimary: () {}, // arama iconu olayı
                  secondaryIcon: Icon(
                    // sağda yer alan icon: konum
                    Icons.location_on_rounded,
                    color: primaryColor,
                  ),
                  onPressedSecondary: () {}, //konum iconu olayı
                ),
                //---------------------------------------------------
              ),
              //------------------Sayfa Başlığı-----------------------
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Favori\nBölgeler", //Büyük Başlık
                        style: TextStyle(
                          fontFamily: leadingFont,
                          color: Colors.white,
                          fontSize: 55,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Lütfen en az bir tane bölge seçiniz.", // Alt Başlık
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //-----------------------------------------------------
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: defaultPadding),
                child: Container(
                  // arkaplan containerı
                  decoration: BoxDecoration(
                    color: lightWhite,
                    borderRadius: BorderRadius.vertical(
                      //dikeyde yuvarlatılmış
                      top: Radius.circular(maxSpace),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: defaultPadding),
                    //-------------------List Itamları---------------------------
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical, //dikeyde kaydırılabilir
                      shrinkWrap: true,
                      itemCount:
                          _location.length, //_location mapi uzunluğu kadar
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(
                              20, 0, 20, 0), // yalnızca sol ve sağdan boşluk

                          //InkWell sarmaladığı widgeta tıklanabilirlik özelliği kazandırdı
                          //InkWell ile liste yapısının tamamı tıklanabilir hale geldi
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                //_location mapinin keyleri listeye çevrildi ve tıklandığında true olarak güncellendi
                                _location.update(_location.keys.toList()[index],
                                    (value) => !value);
                              });
                            },
                            child: Container(
                              //locationların listeleneceği card genişliği
                              height: 80,
                              decoration: BoxDecoration(
                                // Container rengi gradient ile verildi
                                gradient: LinearGradient(
                                  //soldan sağa doğru color listteki renkleri yaydı
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                  //_location mapinin value(true - false) değerlerinin indexine göre rengi kontrol ediyor
                                  colors: _location.values.toList()[index]
                                      ? backGroundColor1 // true ise(seçili) ise renk koyu
                                      : backGroundColor3, // false ise seçilmemişse açık
                                ),
                              ),
                              child: Center(
                                //Bir seçim radiosu ve text yapısından oluşan listTile
                                child: ListTile(
                                  //İç container yapısı
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.topRight,
                                        //_location mapinin valuelarının index değerine göre renk belirler
                                        colors: _location.values.toList()[index]
                                            ? backGroundColor1 // true ise(seçili) ise renk koyu
                                            : backGroundColor3, // false ise seçilmemişse açık
                                      ),
                                    ),
                                    //Dış container yapısı
                                    child: Container(
                                      width: 34,
                                      height: 34,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: lightWhite,
                                            width:
                                                6.0 // beyaz halkanın genişliği
                                            ),
                                      ),
                                    ),
                                  ),
                                  //_location isimlerinin gösterildiği text
                                  title: Text(
                                    _location.keys.toList()[index], //_location mapinin keylerinin indexine göre ekrana yazar
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: _location.values.toList()[index] 
                                          ? Colors.white // seçili ise açık text
                                          : primaryColor, // seçili değilse koyu
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      //separatorBuilder list itemları arasına bir widget koymayı sağlar
                      //SizedBox ile itemlar arası boşluk sağlandı
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: minSpace,
                        );
                      },
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
