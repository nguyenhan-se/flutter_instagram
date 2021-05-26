import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String content;

  const ErrorDialog({Key key, this.title = 'Error', @required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _showIOSDialog(context),
    );
  }

  CupertinoAlertDialog _showIOSDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('ok'),
        )
      ],
    );
  }
}
