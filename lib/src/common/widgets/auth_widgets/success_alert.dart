import 'package:flutter/material.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';

void successAuthAlertWidget(
    BuildContext context, String message, String messageHeader) {
  TextTheme textTheme = Theme.of(context).textTheme;
  Alert(
    context: context,
    type: AlertType.success,
    buttons: [],
    content: SizedBox(
      child: Column(
        children: [
          verticalGap(7),
          Text(
            messageHeader,
            // textAlign: TextAlign.center,
            style: textTheme.titleMedium,
          ),
          verticalGap(12),
          Text(
            message,
            // textAlign: TextAlign.center,
            style: textTheme.displaySmall,
          )
        ],
      ),
    ),
    style: const AlertStyle(
        descStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
  ).show();
}
