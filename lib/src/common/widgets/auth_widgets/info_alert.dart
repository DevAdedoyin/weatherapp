import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/constants/app_colors.dart';

void infoAuthAlertWidget(
    BuildContext context, String message, String messageHeader,
    {Function? onTap}) {
  TextTheme textTheme = Theme.of(context).textTheme;
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
            // textAlign: TextAlign.center,
            style: textTheme.headlineMedium,
          ),
          verticalGap(12),
          Text(
            message,
            // textAlign: TextAlign.center,
            style: textTheme.headlineSmall,
          ),
          verticalGap(10),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () => onTap!(),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 2)),
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.accentColor),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              child: const Text("Proceed",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ),
          )
        ],
      ),
    ),
    style: const AlertStyle(
        descStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
  ).show();
}
