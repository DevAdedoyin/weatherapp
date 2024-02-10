import 'package:flutter/material.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';

void successAuthAlertWidget(
        BuildContext context, String message, String messageHeader) =>
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
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            verticalGap(12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            )
          ],
        ),
      ),
      style: const AlertStyle(
          descStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    ).show();
