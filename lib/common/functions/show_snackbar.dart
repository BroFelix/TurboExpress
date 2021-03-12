import 'package:flutter/material.dart';

showSnackBar(context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
