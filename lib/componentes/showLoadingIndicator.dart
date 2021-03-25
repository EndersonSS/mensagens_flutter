import 'package:flutter/material.dart';
import 'package:mensagens/componentes/loadingIndicator.dart';

class DialogBuilder {
  DialogBuilder(this.context);

  final BuildContext context;

  Future<void> showLoadingIndicator([String? text]) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: Colors.white,
              content: LoadingIndicator(text: text!),
            ));
      },
    );
  }

  void hideOpenDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
