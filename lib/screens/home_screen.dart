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
              ? ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: FadeInImage(
                            image: NetworkImage(
                                exerciseHub.exercises[index].thumbnail),
                            placeholder: AssetImage('assets/placeholder.jpg'),
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            fit: BoxFit.cover),
                      ),
                    );
                  },
                  itemCount: exerciseHub.exercises.length)
              : LinearProgressIndicator(),
        ));
  }
}
