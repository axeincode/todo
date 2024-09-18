import 'package:flutter/material.dart';
import 'package:todo/utils/add_task_dialog.dart';
import 'package:todo/utils/todo_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  //list of todo tasks
  List toDoList = [
    ['Make Tutorial', false],
    ['Do Exercise', false]
  ];
  final _controller = TextEditingController();
  // checkbox was taped
  void checkBoxChanged(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
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
      toDoList.add([_controller.text, false]);
    });
    _controller.clear();
    Navigator.of(context).pop();
  }
  //cancel new task
  void cancelNewTask() {
    _controller.clear();
    Navigator.of(context).pop();
  }
  //delete a task
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
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
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return TodoTitle(
            name: toDoList[index][0],
            isCompleted: toDoList[index][1],
            onChanged: (val) => checkBoxChanged(index),
            onDelete: (context) => deleteTask(index),
          );
        }
      ) 
    );
  }
}