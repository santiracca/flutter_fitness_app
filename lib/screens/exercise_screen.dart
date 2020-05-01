import 'package:flutter/material.dart';
import './exercises_hub.dart';
import 'dart:async';

class ExerciseScreen extends StatefulWidget {
  final Exercises exercises;

  final int seconds;

  ExerciseScreen({this.exercises, this.seconds});
  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  bool _isCompleted = false;
  int _elapsedSeconds = 0;

  Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (t) {
        if (t.tick == widget.seconds) {
          t.cancel();
          setState(() {
            _isCompleted = true;
          });
        }
        setState(() {
          _elapsedSeconds = t.tick;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image(
              image: NetworkImage(widget.exercises.gif),
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          _isCompleted != true
              ? SafeArea(
                  child: Container(
                    padding: EdgeInsets.only(top: 100),
                    child: Text(
                      "${_elapsedSeconds}s / ${widget.seconds}s",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.lightBlue),
                    ),
                    alignment: Alignment.topCenter,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
