import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Screens/SplashScreen.dart';
import 'package:to_do_app/Screens/homePage.dart';
import 'package:to_do_app/components/cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (context) => ToDoCubit()..createDB(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
    )
    );
  }
}
