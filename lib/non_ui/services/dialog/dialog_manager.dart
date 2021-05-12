import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'dialog_service.dart';

class DialogManager extends StatefulWidget {
  final Widget child;

  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = DialogService.instance;

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(AlertRequest request) {
    Alert(
        context: context,
        title: request.title,
        style: AlertStyle(
            alertAlignment: Alignment.center,
            titleStyle: TextStyle(fontSize: 18, color: Colors.red),
            descStyle: TextStyle(fontSize: 16),
            titleTextAlign: TextAlign.center),
        desc: request.description,
        buttons: [
          DialogButton(
            child: Text(
              request.buttonTitle,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _dialogService.dialogComplete(AlertResponse(confirmed: true));
              Navigator.of(context).pop();
            },
          )
        ]).show();
  }
}
