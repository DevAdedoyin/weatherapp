import 'package:flutter/material.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';



void successAuthAlertWidget(BuildContext context, String? username, email) => Alert(
      context: context,
      type: AlertType.success,
      buttons: [],
      content: SizedBox(
        child: Column(
          children: [
            verticalGap(7),
            const Text(
              "REGISTRATION SUCCESSFUL",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            verticalGap(12),
            Text(
              "Hi $username, Your registration is almost complete. Kindly check your email address for a verification link.",
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
