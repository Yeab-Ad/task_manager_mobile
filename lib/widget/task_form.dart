import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/bloc/event/task_event.dart';
import 'package:task_manager_app/bloc/task_bloc.dart';
import 'package:task_manager_app/model/task_model.dart';

class TaskForm extends StatefulWidget {
  final Task? task;

  const TaskForm({this.task});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late DateTime _dueDate;
  late String _priority;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task!.title;
      _description = widget.task!.description;
      _dueDate = widget.task!.dueDate;
      _priority = widget.task!.priority as String;
      _completed = widget.task!.completed;
    } else {
      _dueDate = DateTime.now();
      _priority = 'low';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: _title,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              onSaved: (value) => _title = value!,
            ),
            TextFormField(
              initialValue: _description,
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
              onSaved: (value) => _description = value!,
            ),
            SizedBox(height: 16),
            Text('Due Date: ${_dueDate.toString()}'),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _priority,
              decoration: InputDecoration(labelText: 'Priority'),
              items: ["low", "medium", "high"]
                  .map(
                      (e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => _priority = value!),
            ),
            SizedBox(height: 16),
            CheckboxListTile(
              value: _completed,
              onChanged: (value) => setState(() => _completed = value!),
              title: Text('Completed'),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (widget.task == null) {
                    BlocProvider.of<TaskBloc>(context).add(TaskCreate(
                      title: _title,
                      description: _description,
                      dueDate: _dueDate,
                      priority: _priority,
                      completed: _completed,
                    ));
                  } else {
                    BlocProvider.of<TaskBloc>(context).add(TaskUpdate(
                      id: widget.task!.id,
                      title: _title,
                      description: _description,
                      dueDate: _dueDate,
                      priority: _priority,
                      completed: _completed,
                    ));
                  }
                  Navigator.pop(context);
                }
              },
              child: Text(widget.task == null ? 'Create' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
