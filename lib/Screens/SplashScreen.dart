import 'package:flutter/material.dart';
import 'package:to_do_app/Screens/homePage.dart';
import 'package:to_do_app/Screens/todo_layout.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ToDoLayout();
      }));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 86, 108, 145),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 120,
              backgroundImage: NetworkImage(
                  "https://th.bing.com/th?id=OIP.WXxM16nmngq0VdD6EyZvywHaE8&w=306&h=204&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2"),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Quiz App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 38,
                fontFamily: 'DancingScript',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(color: Colors.white54),
          ],
        ),
      ),
    );
  }
}
