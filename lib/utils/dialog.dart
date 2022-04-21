import 'package:flutter/material.dart';
import 'package:study/utils/meta/text.dart';

Future<bool> showConfirmationDialog(
    {required BuildContext context, String? title, String? content}) async {
  bool? isConfirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: title != null ? Text(title) : null,
      content: content != null ? Text(content) : null,
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(MetaText.of(context).cancel)),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(MetaText.of(context).agree))
      ],
    ),
  );
  return isConfirmed ?? false;
}
