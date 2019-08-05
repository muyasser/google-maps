import 'package:flutter/material.dart';

class Modal {
  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Column(
            children: <Widget>[
              Text('Modal is here'),
              Text('Modal is here'),
              Text('Modal is here'),
            ],
          ),
        );
      },
    );
  }
}
