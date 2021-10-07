import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../settings/consts.dart';
import 'leadingRowWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeContainerWidget extends StatefulWidget {
  //homePage sayfasında post görünümü oluşturulmasında kullanıldı
  final String cardText; // resimde yer alacak metin
  final String companyLogo; // resimde yer alacak metin
  final String companyName; // resimde yer alacak metin
  final String contentPicture;
  final VoidCallback onPressed; // detaylı bilgi butonu olayı
  final Widget child, likeButton, starButton;
  final Color pinColor;
  final VoidCallback onPressedLocation, onPressedPhone, homeDetailOntap, logoOnTap;

  const HomeContainerWidget(
      {Key key, this.cardText, this.onPressed, this.child, this.pinColor, this.companyLogo, this.companyName, this.contentPicture,this.onPressedLocation, this.onPressedPhone, this.likeButton, this.starButton, this.homeDetailOntap, this.logoOnTap})
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
          height: 350, //container yüksekliği
          decoration: BoxDecoration(
            color: lightWhite,
            borderRadius: BorderRadius.circular(maxSpace), //container kenarlarının yuvarlatılması
          ),
          child: Column(
            children: [
              //Yalnızca alt ve üst boşluk paddingi
              Padding(
                padding: const EdgeInsets.only(top: maxSpace, bottom: maxSpace),
                //Leading Widgetı
                child: LeadingRowWidget(
                  companyLogo: widget.companyLogo,
                  companyName: widget.companyName,
                  starButton: widget.starButton,
                  logoOnTap: widget.logoOnTap,
                ),
              ),
              Flexible(
                //resim containerının yalnızca sağ ve sol boşluk veren paddingi
                child: Padding(
                  padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                  //--------------Resmi çevreyelecek container yapısı------------------
                  child: GestureDetector(
                    child: ClipRRect(
                      child: Container(
                       width: deviceWidth(context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(maxSpace), //Resmin kenarlarının yuvarlatılması
                          image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: CachedNetworkImageProvider(widget.contentPicture),
                          ),
                        ),
                        //------------------------------------------------------------------
                    
                        //----------------Resim üzerinde yer alacak yapılar-----------------
                       child: Align(alignment: Alignment.bottomLeft, // cardText'in sol alta konumlandırılması
                                child: Padding(padding: EdgeInsets.only(left: maxSpace,bottom: deviceHeight(context)*0.01),
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
                             
                      ),
                    ),
                    onTap: widget.homeDetailOntap,
                  ),
                ),
              ),
              //-------------------------------------ICONBUTTONLAR PANELİ----------------------------------------
              Padding(
                padding:const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                child: Container(
                        width: deviceWidth(context),
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.end, //Tüm widgetlar container altına konumlandırılsın
                        children: [
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
                                  //------------------------------BEĞEN ICONBUTTONI-------------------------------
                                      widget.likeButton,
                                  //------------------------------------------------------------------------------
                                  // //------------------------------PAYLAŞ ICONBUTTONI---------------------------
                                  //   IconButton(icon: Icon(Icons.share_outlined,color: primaryColor),
                                  //   onPressed: () {}),
                                  // //---------------------------------------------------------------------------
                                  //------------------------------İLETİŞİM ICONBUTTONI----------------------------
                                    IconButton(icon: Icon(LineIcons.phone,color: primaryColor),
                                        onPressed: widget.onPressedPhone),
                                  //------------------------------------------------------------------------------
                                  //-----------------------------KONUM ICONBUTTONI--------------------------------
                                    IconButton(icon: Icon(LineIcons.locationArrow,color: primaryColor,size : iconSize),
                                        onPressed: widget.onPressedLocation)
                                  //------------------------------------------------------------------------------
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
                      )),
              ),
              //-------------------------------------------------------------------------------------------------
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
          thickness: 1.5,
        ),
        SizedBox(height: maxSpace), // Post üstü - divider arası boşluk
      ],
    );
  }
}
