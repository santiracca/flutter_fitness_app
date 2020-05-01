import 'package:fitness_app/screens/exercise_start_screen.dart';

import './exercises_hub.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiURL =
      'https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json';

  ExerciseHub exerciseHub;

  @override
  void initState() {
    getExercises();
    super.initState();
  }

  void getExercises() async {
    var response = await http.get(apiURL);
    var body = response.body;
    var decodedJson = jsonDecode(body);
    setState(() {
      exerciseHub = ExerciseHub.fromJson(decodedJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Fitness App')),
        body: Container(
          child: exerciseHub != null
              ? ListView(
                  children: exerciseHub.exercises.map((e) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => ExerciseStartScreen(
                              exercises: e,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: e.id,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: FadeInImage(
                                  image: NetworkImage(e.thumbnail),
                                  placeholder:
                                      AssetImage('assets/placeholder.jpg'),
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF0000000),
                                          Color(0x000000000)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.center),
                                  ),
                                ),
                              ),
                              Container(
                                height: 250,
                                padding: EdgeInsets.only(left: 10, bottom: 20),
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  e.title,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )
              : LinearProgressIndicator(),
        ));
  }
}
