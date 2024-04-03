import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';

void failedAuthAlertWidget(
    BuildContext context, String message, String messageHeader) {
  TextTheme textTheme = Theme.of(context).textTheme;
  Alert(
    context: context,
    type: AlertType.error,
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
          ),
          verticalGap(7),
          ElevatedButton(
            onPressed: () {
              context.pop();
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            child: const Text("Ok",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          )
        ],
      ),
    ),
    style: const AlertStyle(
        descStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
  ).show();
}
