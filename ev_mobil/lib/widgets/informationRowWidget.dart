import 'package:ev_mobil/settings/consts.dart';
import 'package:flutter/material.dart';

class InformationRowWidget extends StatelessWidget {
  final String operationName;
  final double width;
  final double height;
  final Widget child;
  final Color containerColor;

  const InformationRowWidget(
      {Key key, this.operationName, this.width, this.height, this.child, this.containerColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$operationName:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: Center(
                child: child,
              ),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
      ],
    );
  }
}
