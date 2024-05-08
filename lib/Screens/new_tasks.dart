import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/components/components.dart';
import 'package:to_do_app/components/cubit.dart';
import 'package:to_do_app/components/states.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit,ToDoStates>(
      listener: (BuildContext context,ToDoStates state){},
      builder: (BuildContext context,ToDoStates state){
        List<Map> tasks = ToDoCubit.get(context).newTasks;
        return tasksBuilder(tasks: tasks);
      },
    );
  }
}