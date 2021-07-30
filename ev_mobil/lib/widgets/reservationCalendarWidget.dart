import 'package:ev_mobil/settings/consts.dart';
import 'package:ev_mobil/widgets/tableCalendarWidget.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //-------------------------Takvim sayfası-------------------------------
        Padding(
          padding: const EdgeInsets.only(right: defaultPadding, left: defaultPadding),
          child  : TableCalendarWidget(), // takvim
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
        //----------------------------------------------------------------------
        SizedBox(height: minSpace), //Saat uyarı metni - takvim arası boşluk

        //------------------------Saat uyarı metni------------------------------
        Padding(padding: const EdgeInsets.only(left: defaultPadding),
          child: Align(alignment: Alignment.topLeft,
          child: Text("*Lütfen bir saat seçiniz")),
        ),
        //----------------------------------------------------------------------

        //----------------------Saat Widgetlarının Tablosu----------------------
        GridView.custom(
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
        //----------------------------------------------------------------------
      ],
    );
  }
}
