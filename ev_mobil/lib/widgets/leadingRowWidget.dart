import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class LeadingRowWidget extends StatefulWidget {
  //homePage ve favoritePage sayfalarında kullanıldı
 @required final String companyLogo; // icon resmi indexi
 @required final Color pinColor;
 @required final String companyName;

  const LeadingRowWidget({Key key, this.pinColor, this.companyLogo, this.companyName});

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
            SizedBox(width: deviceWidth(context)*0.08), 
            Container(
              alignment: Alignment.topLeft,
              width: deviceWidth(context)*0.1,
              height: deviceWidth(context)*0.1,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
              image: NetworkImage(
                //companies[widget.iconNumber].imgUrl, //stories listesinden icon indexi çekme
                widget.companyLogo,
              ),
             ),
            ),
            ),
            //-----------------------------------------------------
            SizedBox(width: deviceWidth(context)*0.05), //başlık iconu - texti arası boşluk

            Text(
              widget.companyName,
              style: TextStyle(fontSize: 20)
              //Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        IconButton(
          // pin butonu
          icon: Icon(FontAwesomeIcons.thumbtack,color: widget.pinColor,size: 20),
          onPressed: (){}, // olayı parametre alındı
        ),
       
      ],
    );
  }
}
