import 'package:ev_mobil/settings/consts.dart';
import 'package:flutter/material.dart';

class GridViewChildWidget extends StatefulWidget {
  final String time;

  const GridViewChildWidget({
    Key key,
    this.time,
  }) : super(key: key);

  @override
  _GridViewChildWidgetState createState() => _GridViewChildWidgetState();
}

class _GridViewChildWidgetState extends State<GridViewChildWidget> {
  Map<String, bool> pressed = {"variable": false};

  @override
  Widget build(BuildContext context) {
    return Container(
      color: pressed.values.first ? secondaryColor : Colors.white,
      child: TextButton(
        child: Text(
          widget.time,
          style: TextStyle(
            color: pressed.values.first ? Colors.white : primaryColor,
          ),
        ),
        onPressed: () {
          setState(() {});
          //butona basıldığında değeri günceller
          pressed.updateAll((key, value) => !value);
        },
      ),
    );
  }
}
