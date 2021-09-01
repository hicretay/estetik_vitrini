import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../settings/consts.dart';
import 'leadingRowWidget.dart';

class HomeContainerWidget extends StatefulWidget {
  //homePage sayfasında post görünümü oluşturulmasında kullanıldı


  final String cardText; // resimde yer alacak metin
  final String companyLogo; // resimde yer alacak metin
  final String companyName; // resimde yer alacak metin
  final String contentPicture;
  final String companyPhone;
  final VoidCallback onPressed; // detaylı bilgi butonu olayı
  final Widget child;
  final Color pinColor;
  final bool checked;
  final VoidCallback onPressedLocation;

  const HomeContainerWidget(
      {Key key, this.cardText, this.onPressed, this.child, this.pinColor, this.companyLogo, this.companyName, this.contentPicture, this.checked, this.onPressedLocation, this.companyPhone})
      : super(key: key);

  @override
  _HomeContainerWidgetState createState() => _HomeContainerWidgetState();
}

class _HomeContainerWidgetState extends State<HomeContainerWidget> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //-----------------------------Postu çevreleyecek container yapısı-------------------------
        Container(
          width: double.infinity, //genişlik: container genişliği kadar
          height: 300, //container yüksekliği
          decoration: BoxDecoration(
            color: lightWhite,
            borderRadius: BorderRadius.circular(
                maxSpace), //container kenarlarının yuvarlatılması
          ),
          child: Column(
            children: [
              //Yalnızca alt ve üst boşluk paddingi
              Padding(
                padding: const EdgeInsets.only(top: maxSpace, bottom: maxSpace),
                //Leading Widgetı
                child: LeadingRowWidget(
                  //iconNumber: widget.iconNumber, // icon resmi indexi
                  pinColor: widget.pinColor,
                  companyLogo: widget.companyLogo,
                  companyName: widget.companyName,
                ),
              ),
              Flexible(
                //resim containerının yalnızca sağ ve sol boşluk veren paddingi
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: maxSpace, right: maxSpace),
                  //--------------Resmi çevreyelecek container yapısı------------------
                  child: Container(
                    width: deviceWidth(context),
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(maxSpace), //Resmin kenarlarının yuvarlatılması
                      image: DecorationImage(
                        fit: BoxFit.fill, // Resim containerı kaplasın
                        image: NetworkImage(
                          widget.contentPicture
                        ),
                      ),
                    ),
                    //------------------------------------------------------------------

                    //----------------Resim üzerinde yer alacak yapılar-----------------
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end, //Tüm widgetlar container altına konumlandırılsın
                      children: [
                        Align(alignment: Alignment.bottomLeft, // cardText'in sol alta konumlandırılması
                          child: Padding(padding: const EdgeInsets.only(left: maxSpace),
                            child: Text(
                              widget.cardText, //Kendin için bir şeyler yap metni
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
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
                          height: 40,
                          child: Row(
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                //---------------------------BEĞEN ICONBUTTONI-----------------------------
                                    IconButton( icon: checked
                                            ? Icon(Icons.favorite,
                                                color: primaryColor)
                                            : Icon(LineIcons.heart,
                                                color: primaryColor),
                                        onPressed: () {
                                          setState(() {
                                            checked = !checked;
                                          });
                                        }),
                                //-------------------------------------------------------------------------
                                //------------------------------PAYLAŞ ICONBUTTONI---------------------------
                                  IconButton(icon: Icon(Icons.share_outlined,color: primaryColor),
                                  onPressed: () {}),
                                //--------------------------------------------------------------------------
                                // //----------------------------İLETİŞİM ICONBUTTONI--------------------------
                                //   IconButton(icon: Icon(LineIcons.phone,color: primaryColor),
                                //       onPressed: () {
                                //         showAlert(context,"İletişim" + "\n${widget.companyPhone}");
                                //       }),
                                // //----------------------------------------------------------------------------
                                //-----------------------------KONUM ICONBUTTONI----------------------------
                                  IconButton(icon: Icon(LineIcons.locationArrow,color: primaryColor,size : iconSize),
                                      onPressed: widget.onPressedLocation)
                                //------------------------------------------------------------------------
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: widget.onPressed,
                                child: Row(
                                  children: [
                                    Text(
                                      "Detaylı Bilgi İçin",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(color: primaryColor),
                                    ),
                                    SizedBox(width: minSpace),
                                    //Buton texti - icon arası boşluk
                                    Icon( LineIcons.arrowRight, // sağa ok ikonu
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
