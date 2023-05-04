import 'package:flutter/material.dart';

class Animal{
  String? imagePath;
  String? animalName;
  String? kind;
  bool? flyExist=false;

  Animal({
    this.imagePath,
    this.animalName,
    this.kind,
    this.flyExist});
}