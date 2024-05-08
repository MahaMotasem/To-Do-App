import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/Screens/archive_tasks.dart';
import 'package:to_do_app/Screens/done_tasks.dart';
import 'package:to_do_app/Screens/new_tasks.dart';
import 'package:to_do_app/components/states.dart';

class ToDoCubit extends Cubit<ToDoStates> {
  ToDoCubit() : super(InitialState());
  static ToDoCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(changeCurrentIndexState());
  }

  List<Widget> screens = const [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  late Database db;
  List<Map<String, dynamic>> newTasks = [];
  List<Map<String, dynamic>> doneTasks = [];
  List<Map<String, dynamic>> archivedTasks = [];

   bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  // void changeCurrentIndex(index) {
  //   currentIndex = index;
  //   emit(SwapBottomNavBar());
  // }

  void changeBottomSheetState({
    required bool isShown,
    required IconData icon,
  }) {
    isBottomSheetShown = isShown;
    fabIcon = icon;
    emit(SwapBottomSheetState());
  }


  void createDB() async {
    await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE tasks(ID INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)
        ''').then((value) {
          print('table created');
        });
      },
      onOpen: (db) {
        print('open database');
        getRecordsFromDB();
      },
    ).then((value) {
      db = value;
    }).catchError((error) {
      print(error.toString());
    });
  }

  void getRecordsFromDB() async {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(GetRecordsLoadingState());

    await db
        .rawQuery(
      'SELECT * FROM tasks',
    )
        .then((value) {
      for (var row in value) {
        if (row['status'] == 'new') {
          newTasks.add(row);
        } else if (row['status'] == 'done') {
          doneTasks.add(row);
        } else {
          archivedTasks.add(row);
        }
      }
      emit(GetRecordsState());
    }).catchError((error) {
      print(error.toString());
    });
  }

  void insertDB({
    required String title,
    required String date,
    required String time,
    String status = 'new',
  }) async {
    await db
        .rawInsert(
            'INSERT INTO tasks(title, date, time, status) VALUES("$title" , "$date","$time","$status")')
        .then((value) {
      // this value is the ID to this insertedRow
      emit(InsertState());
      getRecordsFromDB();
      print('insert success : $value');
    }).catchError((error) {
      print(error.toString());
    });
  }

  void updateDB({
    required String status,
    required int id,
  }) async {
    await db.rawUpdate(
      'UPDATE tasks SET status=? WHERE id=?',
      [status, id],
    ).then((value) {
      emit(UpdateState());
      getRecordsFromDB();
    });
  }

  void deleteFromDB({required int id}) async {
    await db.rawDelete('DELETE FROM tasks WHERE id=?', []).then((value) {
      print('delete successfully');
      emit(DeleteState());
      getRecordsFromDB();
    });
  }
}
