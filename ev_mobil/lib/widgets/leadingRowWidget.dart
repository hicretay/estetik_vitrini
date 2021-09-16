import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';


class LeadingRowWidget extends StatefulWidget {
  //homePage ve favoritePage sayfalarında kullanıldı
 @required final String companyLogo; // icon resmi indexi
 @required final Color pinColor;
 @required final String companyName;
 final Color leadingColor;
 final VoidCallback starButtonOnPressed;

  const LeadingRowWidget({Key key, this.pinColor, this.companyLogo, this.companyName, this.leadingColor, this.starButtonOnPressed});

  @override
  _LeadingRowWidgetState createState() => _LeadingRowWidgetState();
}

class _LeadingRowWidgetState extends State<LeadingRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Row içindeki widgetların yayılmasını sağlar
      children: [
        Row(
          children: [
            //------------Başlıktaki firma logosu görünümü-----------
            SizedBox(width: deviceWidth(context)*0.03), 
            Container(
              child: Container(
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
            ),
            //-----------------------------------------------------
            SizedBox(width: deviceWidth(context)*0.03), //başlık iconu - texti arası boşluk

            SizedBox(
              width: deviceWidth(context)*0.63,
              child: Text(
                widget.companyName,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(fontSize: 17, fontFamily: headerFont,color: widget.leadingColor)
              ),
            ),
          ],
        ),
        IconButton(
          // pin butonu
          icon: Icon(LineIcons.star,color: widget.pinColor,size: 26),
          onPressed: widget.starButtonOnPressed, // olayı parametre alındı
        ),
       SizedBox(width: deviceWidth(context)*0.01),      
      ],
    );
  }
}
