import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';

class InformationRowWidget extends StatefulWidget {
  final String operationName;
  final double width;
  final double height;
  final Widget child;
  final Color containerColor;

  const InformationRowWidget(
      {Key key, this.operationName, this.width, this.height, this.child, this.containerColor});

  @override
  _InformationRowWidgetState createState() => _InformationRowWidgetState();
}

class _InformationRowWidgetState extends State<InformationRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${widget.operationName}:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Theme.of(context).hintColor),
            ),
            Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.containerColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(minSpace),
                ),
              ),
              child: Center(
                child: widget.child,
              ),
            ),
          ],
        ),
        SizedBox(height: maxSpace),
      ],
    );
  }
}
