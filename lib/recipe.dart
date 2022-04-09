import 'dart:io';

import 'package:flutter_application_1/ingradient.dart';

class Recipe{
  String name;
  File imgFile;
  int serving;
  List<Ingradient> ingradients;
  Recipe(this.name, this.imgFile, this.serving, this.ingradients);
}