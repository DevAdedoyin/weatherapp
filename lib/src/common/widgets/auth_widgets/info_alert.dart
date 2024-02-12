import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/constants/app_colors.dart';

void infoAuthAlertWidget(
        BuildContext context, String message, String messageHeader) =>
    Alert(
      context: context,
      type: AlertType.info,
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
            ),
            verticalGap(10),
            ElevatedButton(
              onPressed: () {
                // context.pop();
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 2)),
                  backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              child: const Text("Proceed",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            )
          ],
        ),
      ),
      style: const AlertStyle(
          descStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    ).show();
