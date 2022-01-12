import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';

class GridViewChildWidget extends StatefulWidget {
  final String? time;

  const GridViewChildWidget({
    Key? key,
    this.time,
  }) : super(key: key);

  @override
  _GridViewChildWidgetState createState() => _GridViewChildWidgetState();
}

class _GridViewChildWidgetState extends State<GridViewChildWidget> {
  //Map<String, bool> pressed = {"variable": false};
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isPressed ? secondaryColor : Colors.white,
      child: TextButton(
        child: Text(
          widget.time!,
          style: TextStyle(
            color: isPressed ? Colors.white : primaryColor,
          ),
        ),
        onPressed: () {
          setState(() {
            isPressed = !isPressed;
            //butona basıldığında değeri günceller
          });
        },
      ),
    );
  }
}
