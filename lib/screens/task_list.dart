import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/bloc/event/task_event.dart';
import 'package:task_manager_app/bloc/state/task_state.dart';
import 'package:task_manager_app/bloc/task_bloc.dart';
import 'package:task_manager_app/widget/task_detail.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<TaskBloc>().add((TaskFetchAll()));

    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TaskSuccess) {
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              print(task);
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetail(task: task),
                    ),
                  );
                },
              );
            },
          );
        } else if (state is TaskFailure) {
          return Center(child: Text(state.error));
        } else {
          return Center(child: Text('No tasks available'));
        }
      },
    );
  }
}
