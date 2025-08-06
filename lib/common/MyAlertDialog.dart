import 'package:flutter/material.dart';

class MyAlertDialog extends StatefulWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  const MyAlertDialog({super.key,
    required this.title,
    required this.content,
    this.actions = const [],
  });

  @override
  State<MyAlertDialog> createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  double h=0.0;

  double w=0.0;

  @override
  Widget build(BuildContext context) {
      w=MediaQuery.of(context).size.width;
    h=MediaQuery.of(context).size.height;
    return  AlertDialog(
      title: Text(
        widget.title,
      ),
      actions: widget.actions,
      content: Text(
        widget.content,
        // style: Theme.of(context).textTheme.body1,
      ),
    );
  }
}