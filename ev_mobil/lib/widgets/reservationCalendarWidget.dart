import 'package:ev_mobil/settings/consts.dart';
import 'package:ev_mobil/widgets/makeReservationWidget.dart';
import 'package:ev_mobil/widgets/tableCalendarWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:table_calendar/table_calendar.dart';
import 'gridViewChildWidget.dart';

class ReservationCalendarWidget extends StatefulWidget {
  const ReservationCalendarWidget({
    Key key,
  }) : super(key: key);


  @override
  _ReservationCalendarWidgetState createState() =>
      _ReservationCalendarWidgetState();
}

class _ReservationCalendarWidgetState extends State<ReservationCalendarWidget> {
  var gridChildren = <Widget>[
    GridViewChildWidget(
      time: "08.00",
    ),
    GridViewChildWidget(
      time: "08.30",
    ),
    GridViewChildWidget(
      time: "9.00",
    ),
    GridViewChildWidget(
      time: "09.30",
    ),
    GridViewChildWidget(
      time: "10.00",
    ),
    GridViewChildWidget(
      time: "10.30",
    ),
    GridViewChildWidget(
      time: "11.00",
    ),
    GridViewChildWidget(
      time: "11.30",
    ),
    GridViewChildWidget(
      time: "12.00",
    ),
    GridViewChildWidget(
      time: "12.30",
    ),
    GridViewChildWidget(
      time: "13.00",
    ),
    GridViewChildWidget(
      time: "13.30",
    ),
    GridViewChildWidget(
      time: "14.00",
    ),
    GridViewChildWidget(
      time: "14.30",
    ),
    GridViewChildWidget(
      time: "15.00",
    ),
    GridViewChildWidget(
      time: "15.30",
    ),
    GridViewChildWidget(
      time: "16.00",
    ),
    GridViewChildWidget(
      time: "16.30",
    ),
    GridViewChildWidget(
      time: "17.00",
    ),
    GridViewChildWidget(
      time: "17.30",
    ),
  ];
   bool checked = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [          
          //-------------------------Takvim sayfası-------------------------------
          Padding(
            padding: const EdgeInsets.only(right: defaultPadding, left: defaultPadding),
            child  : checked? TableCalendarWidget(calendarFormat: CalendarFormat.month):  // takvim
            Padding(
              padding:  const EdgeInsets.only(top: defaultPadding*2),
              child: GridView.custom(
                gridDelegate    : SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (1 / .4), //saatler arası hizalama
                crossAxisCount  : 5, // satırdaki widget sayısı
              ),
              childrenDelegate: SliverChildListDelegate(gridChildren),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(0.1),
              scrollDirection: Axis.vertical,
          ),
            ),
          ),
          //----------------------------------------------------------------------
          //--------------------Takvim - Saatler arası çizgi----------------------
          Padding(padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
            child: Divider(
              color : primaryColor,
              height: 1,
              thickness: 1.5,
            ),
          ),
          checked?
          TextButton(
            style: ButtonStyle(),
            onPressed: (){          
           setState(() {
              checked = !checked;
            });
          },
          child: 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
            Text("Randevu saati seçiniz",
            style: TextStyle(
            color: primaryColor,
            fontSize: 18,
            fontFamily: contentFont)),
            SizedBox(width: deviceWidth(context)*0.01),
            FaIcon(FontAwesomeIcons.clock,size: 18,color: secondaryColor,)])
            )
            :
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeReservationWidget()));
                  });
                  //Buton tıklandığında randevu al sayfasına yönlendirilecek
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //-------------Buton Metni-------------
                      Text(
                        "Randevu Bilgilerini Doldur",
                        style: Theme.of(context).textTheme.button.copyWith(color: primaryColor,fontSize: 18),
                      ),
                      //-------------------------------------
                      SizedBox(width: 10), //butondaki Text ve icon arası boşluk
                      Icon(
                        LineIcons.arrowRight, //ileri iconu
                        color: secondaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
