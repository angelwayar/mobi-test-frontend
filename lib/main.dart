import 'package:flutter/material.dart';
import 'package:test_frontend/injection.dart';
import 'app.dart';

void main() {
  Injector().initInjector();
  runApp(const MyApp());
}
