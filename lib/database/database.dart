import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {

  final _myBox = Hive.box('myBox');

  List toDoList = [];

  //initialize the box

  void initBox() {
    toDoList = [
      ['Make Tutorial', false],
      ['Do Exercise', false]
    ];
  }

  //get the database
  void getBox() {
    toDoList = _myBox.get('TODOLIST');
  }
  //update the database
  void updateBox() {
    _myBox.put('TODOLIST', toDoList);
  }
}