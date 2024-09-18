import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class TodoTitle extends StatelessWidget {
  final String name;
  final bool isCompleted;
  Function(bool? val)? onChanged;
  Function(BuildContext) onDelete;

  TodoTitle({
    super.key,
    required this.name,
    required this.isCompleted,
    required this.onChanged,
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(), 
          children: [
            SlidableAction(
              onPressed: onDelete,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
            )
          ]
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              Checkbox(
                value: isCompleted, 
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              Text(
                name, 
                style: TextStyle(decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}