import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';

class LeadingRowWidget extends StatefulWidget {
  //homePage ve favoritePage sayfalarında kullanıldı
 @required final String companyLogo; // icon resmi indexi
 @required final String companyName;
  final Color? leadingColor;
 @required final Widget starButton;
  @required final VoidCallback logoOnTap;
 

  const LeadingRowWidget({Key? key, required this.companyLogo, required this.companyName,  this.leadingColor, required this.starButton, required this.logoOnTap});

  @override
  _LeadingRowWidgetState createState() => _LeadingRowWidgetState();
}

class _LeadingRowWidgetState extends State<LeadingRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Row içindeki widgetların yayılmasını sağlar
      children: [
        GestureDetector(
          child: Row(
            children: [
              //------------Başlıktaki firma logosu görünümü-----------
              SizedBox(width: deviceWidth(context)*0.03), 
               Container(
                  alignment: Alignment.topLeft,
                  width: deviceWidth(context)*0.15,
                  height: deviceWidth(context)*0.15,
                  decoration: BoxDecoration(
                  color: white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                  image: NetworkImage(
                    widget.companyLogo,
                  ),
                 ),
                ),
               ),
              //-----------------------------------------------------
              SizedBox(width: deviceWidth(context)*0.03), //başlık iconu - texti arası boşluk
        
              SizedBox(
                width: deviceWidth(context)*0.63,
                child: Text(
                  widget.companyName,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(fontSize: 17, fontFamily: headerFont,color: Colors.white) // widget.leadingColor firma adı rengi düzenleniyor.
                ),
              ),
            ],
          ),
          onTap: widget.logoOnTap,
        ),
        widget.starButton,
       SizedBox(width: deviceWidth(context)*0.01),      
      ],
    );
  }
}
