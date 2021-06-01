import 'package:ev_mobil/settings/consts.dart';
import 'package:ev_mobil/widgets/tableCalendarWidget.dart';
import 'package:flutter/material.dart';
import 'gridViewChidrenWidget.dart';

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
        Padding(
          padding: const EdgeInsets.only(
              right: defaultPadding, left: defaultPadding),
          child: TableCalendarWidget(),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: defaultPadding,right: defaultPadding),
          child: Divider(
            color: primaryColor,
            height: 2,
            thickness: 1.5,
          ),
        ),
        SizedBox(height: minSpace),
        GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 5,
          childAspectRatio: (1 / .4),
          shrinkWrap: true,
          children: gridChildren,
        ),
      ],
    );
  }
}

