import 'package:flutter/material.dart';

SnackBar customSnackBar({
  required String message,
  required void Function() onPressed,
}) {
  return SnackBar(
    content: Text(message),
    action: SnackBarAction(
      label: 'Cerrar',
      onPressed: onPressed,
    ),
  );
}
