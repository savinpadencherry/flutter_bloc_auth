import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_auth/models/custom_error.dart';

errorDialog(BuildContext context, CustomError error) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(error.code),
          content: Text(error.plugin + '\n' + error.message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      });
}
