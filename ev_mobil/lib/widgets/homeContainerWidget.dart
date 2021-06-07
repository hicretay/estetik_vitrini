import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../settings/consts.dart';
import 'leadingRowWidget.dart';

class HomeContainerWidget extends StatefulWidget {
  //homePage sayfasında post görünümü oluşturulmasında kullanıldı
  final int iconNumber; // başlık resmi indexi
  final int imgNumber; // post resmi indexi
  final String cardText; // resimde yer alacak metin
  final VoidCallback onPressed; // detaylı bilgi butonu olayı

  const HomeContainerWidget(
      {Key key, this.iconNumber, this.imgNumber, this.cardText, this.onPressed})
      : super(key: key);

  @override
  _HomeContainerWidgetState createState() => _HomeContainerWidgetState();
}

class _HomeContainerWidgetState extends State<HomeContainerWidget> {
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //-----------------------------Postu çevreleyecek container yapısı-------------------------
        Container(
          width: double.infinity, //genişlik: container genişliği kadar
          height: 300, //container yüksekliği: 300
          decoration: BoxDecoration(
            color: lightWhite,
            borderRadius: BorderRadius.circular(
                maxSpace), //container kenarlarının yuvarlatılması
          ),
          child: Column(
            children: [
              //Yalnızca alt ve üst boşluk paddingi
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                //Leading Widgetı
                child: LeadingRowWidget(
                  iconNumber: widget.iconNumber, // icon resmi indexi
                  onPressed: () {}, // more iconu olayı
                ),
              ),
              Expanded(
                //resim containerının yalnızca sağ ve sol boşluk veren paddingi
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: maxSpace, right: maxSpace),
                  //--------------Resmi çevreyelecek container yapısı------------------
                  child: Container(
                    width: double.infinity, //genişlik: container genişliği
                    height: 250, //container yüksekliği: 250
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          maxSpace), //Resmin kenarlarının yuvarlatılması
                      image: DecorationImage(
                        fit: BoxFit.cover, // Resim containerı kaplasın
                        image: NetworkImage(
                          stories[widget.imgNumber]["img"],
                        ),
                      ),
                    ),
                    //------------------------------------------------------------------

                    //----------------Resim üzerinde yer alacak yapılar-----------------
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .end, //Tüm widgetlar container altına konumlandırılsın
                      children: [
                        Align(
                          alignment: Alignment
                              .bottomLeft, // cardText'in sol alta konumlandırılması
                          child: Padding(
                            padding: const EdgeInsets.only(left: maxSpace),
                            child: Text(
                              widget
                                  .cardText, //Kendin için bir şeyler yap metni
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ),
                        ),
                        //cardText ve alt container arasındaki boşluk
                        SizedBox(height: defaultPadding),

                        //-----------------Butonların yer aldığı container--------------------
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(minSpace),
                          ),
                          width: double.infinity, // genişlik: container kadar
                          height: 40.0, //container yüksekliği: 40
                          child: Row(
                            children: [
                              Expanded(
                                //---------Beğeni, iletişim ve paylaş iconButtonları-----------
                                child: Row(
                                  children: [
                                    IconButton(
                                        icon: _checked
                                            ? Icon(Icons.favorite,
                                                color: primaryColor)
                                            : Icon(LineIcons.heart,
                                                color: primaryColor),
                                        onPressed: () {
                                          setState(() {
                                            _checked = !_checked;
                                          });
                                        }),
                                    IconButton(
                                        icon: Icon(
                                          LineIcons.phone,
                                          color: primaryColor,
                                        ),
                                        onPressed: () {}),
                                    IconButton(
                                        icon: Icon(
                                          Icons.share_outlined,
                                          color: primaryColor,
                                        ),
                                        onPressed: () {}),
                                  ],
                                ),
                                //--------------------------------------------------------------
                              ),
                              TextButton(
                                onPressed: widget.onPressed,
                                child: Row(
                                  children: [
                                    Text(
                                      "Detaylı Bilgi İçin",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            minSpace), //Buton texti - icon arası boşluk
                                    Icon(
                                      LineIcons.arrowRight, // sağa ok ikonu
                                      color: primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        //------------------------------------------------------------------
                      ],
                    ),
                  ),
                ),
              ),
              // Post ana containeri - resim containerı arası alt boşluk
              SizedBox(height: maxSpace),
            ],
          ),
        ),
        //-----------------------------Post Containerı sonu------------------------------------
        SizedBox(height: maxSpace), //Post altı - divider arası boşluk
        Divider(
          //İki post arasında yer alan çizgi
          indent: 130.0,
          endIndent: 130.0,
          height: 1,
          color: lightWhite,
          thickness: 2,
        ),
        SizedBox(height: maxSpace), // Post üstü - divider arası boşluk
      ],
    );
  }
}
