import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/database/database.dart';
import 'package:todo/utils/add_task_dialog.dart';
import 'package:todo/utils/todo_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  //list of todo tasks
  final _myBox = Hive.box('myBox');
  TodoDatabase db = TodoDatabase();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (_myBox.get('TODOLIST') == null) {
      db.initBox();
    } else {
      db.getBox();
    }
  }
  // checkbox was taped
  void checkBoxChanged(int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateBox();
  }
  // open new todo dialog
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AddTaskDialog(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: cancelNewTask,
        );
      }
    );
  }

  //save a task

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
    });
    _controller.clear();
    Navigator.of(context).pop();
    db.updateBox();
  }
  //cancel new task
  void cancelNewTask() {
    _controller.clear();
    Navigator.of(context).pop();
  }
  //delete a task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateBox();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('TO DO '),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.yellow,
        onPressed: createNewTask
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTitle(
            name: db.toDoList[index][0],
            isCompleted: db.toDoList[index][1],
            onChanged: (val) => checkBoxChanged(index),
            onDelete: (context) => deleteTask(index),
          );
        }
      ) 
    );
  }
}