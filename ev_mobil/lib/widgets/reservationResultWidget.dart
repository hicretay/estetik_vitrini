import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResevationResultWidget extends StatelessWidget {
  final String companyName;
  final String operation;
  final String time;

  const ResevationResultWidget({
    Key key, this.companyName, this.operation, this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              DateFormat.yMMMEd('tr_TR').format(
                DateTime.now(),
              ),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ),
        Container(
          color: lightWhite,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          companyName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: minSpace),
                        Text(
                          operation,
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Column(
                      children: [],
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            time,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(width: defaultPadding * 2),
                        Icon(
                          Icons.clear,
                          size: 18,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: defaultPadding),
      ],
    );
  }
}
