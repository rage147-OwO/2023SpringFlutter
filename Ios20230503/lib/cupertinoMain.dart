import 'package:flutter/cupertino.dart';
import 'animalItem.dart';

class CupertinoMain extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CupertinoMain();
  }
}

class _CupertinoMain extends State<CupertinoMain>{
  CupertinoTabBar? tabBar;
  List<Animal> animalList=List.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cupertino Demo',
      home: CupertinoTabScaffold(
        tabBar: tabBar!,
        tabBuilder:(context,value){
          if(value==0){
            return Container(
              child: Center(
                child: Text('cupertino tab 1'),
              ),
            );
          }else{
            return Container(
              child: Center(
                child: Text('cupertino tab 2'),
              ),
            );
          }
        }
      ),
    );
  }
  @override
  void initState() {
    super.initState();

    tabBar=CupertinoTabBar(items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.add)),

    ]);
    animalList.add(Animal(animalName: 'bear',kind: 'animal',imagePath: 'repo/images/bear.png',flyExist: false));
    animalList.add(Animal(animalName: 'cat',kind: 'animal',imagePath: 'repo/images/cat.png',flyExist: false));
    animalList.add(Animal(animalName: 'cow',kind: 'animal',imagePath: 'repo/images/cow.png',flyExist: false));
    animalList.add(Animal(animalName: 'dog',kind: 'animal',imagePath: 'repo/images/dog.png',flyExist: false));
  }
}