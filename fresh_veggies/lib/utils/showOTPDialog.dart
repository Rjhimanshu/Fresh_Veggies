import 'package:flutter/material.dart';
import 'package:fresh_veggies/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

 
void showOTPDialog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text("Enter OTP"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: codeController,
          ),
        ],
      ),

      actions: <Widget>[
       
        TextButton(
          child: Text("Done"),
          onPressed:(){context.vxNav.push(Uri.parse(MyRoutes.homeRoute));
          }
        )
      ],
    ),
  );
}