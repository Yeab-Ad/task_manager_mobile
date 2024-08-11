import 'package:flutter/material.dart';
import 'package:task_manager_app/model/task_model.dart';
import 'task_form.dart';

class TaskDetail extends StatelessWidget {
  final Task task;

  const TaskDetail({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Due Date: ${task.dueDate.toString()}'),
            SizedBox(height: 8),
            Text('Priority: ${task.priority}'),
            SizedBox(height: 8),
            Text('Completed: ${task.completed ? "Yes" : "No"}'),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => TaskForm(task: task),
                    );
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Confirm Delete'),
                        content:
                            Text('Are you sure you want to delete this task?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle delete logic here
                              Navigator.of(context).pop();
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
