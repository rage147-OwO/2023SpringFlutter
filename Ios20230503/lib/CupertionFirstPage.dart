import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './cupertinoMain.dart';
import './animalItem.dart';

class CupertinoMain extends StatelessWidget{
  final List<Animal> animalList;
  const CupertinoMain({Key? key,required this.animalList}) : super(key: key);

  @override
  Widget build(BuildContext) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text('Animals List'),),
        child: Text('Hello World'),
    );
  }
}