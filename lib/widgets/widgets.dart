import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

IconButton iconButton({
  IconData icon,
  Color color,
  Function function,
  double size,
}) {
  return IconButton(
    icon: Icon(
      icon,
      color: color,
      size: size,
    ),
    onPressed: function,
  );
}
