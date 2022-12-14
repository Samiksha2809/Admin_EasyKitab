

import 'package:flutter/material.dart';

import '../Login/login.dart';


class ErrorAlertDialog extends StatelessWidget {
  final String message;
  const ErrorAlertDialog({Key key, this.message}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message),
        actions: <Widget>[
          ElevatedButton(
          onPressed: () {
            Route newRoute = MaterialPageRoute(
                builder: (context) => LoginScreen()
            );
            Navigator.pushReplacement(context, newRoute);
          },
            child: Center(
              child: Text("OK"),
            ),
          )
        ],
    );
  }
}
