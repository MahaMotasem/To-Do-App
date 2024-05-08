import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Screens/archive_tasks.dart';
import 'package:to_do_app/Screens/done_tasks.dart';
import 'package:to_do_app/Screens/new_tasks.dart';
import 'package:to_do_app/components/cubit.dart';
import 'package:to_do_app/components/states.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomShown = false;
  IconData fabIcon = Icons.edit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              ToDoCubit.get(context)
                  .titles[ToDoCubit.get(context).currentIndex],
              style: TextStyle(
                fontFamily: 'DancingScript',
                fontSize: 30,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              
            },
            child: Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: ToDoCubit.get(context).currentIndex,
            elevation: 60,
            onTap: (index) {
              ToDoCubit.get(context).changeCurrentIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.done_outline_rounded),
                label: 'Done',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined),
                label: 'Archived',
              ),
            ],
          ),
          body: ToDoCubit.get(context)
              .screens[ToDoCubit.get(context).currentIndex],
        );
      },
    );
  }
}
