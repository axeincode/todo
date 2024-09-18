import 'package:flutter/material.dart';
import 'package:todo/utils/MyButton.dart';

// ignore: must_be_immutable
class AddTaskDialog extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  AddTaskDialog({super.key, required this.controller, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a new task'
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(name: 'Save', onPressed: onSave),
                const SizedBox(width: 12,),
                MyButton(name: 'Cancel', onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}