import 'package:flutter/material.dart';
import 'constants.dart';

class Cardd extends StatefulWidget {
  final id;
  Cardd({required this.id});

  @override
  State<Cardd> createState() => _CarddState();
}

class _CarddState extends State<Cardd> {
  var url = 'https://api.spoonacular.com/recipes/$id/information';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Image(image: NetworkImage(url))],
      ),
    );
  }
}
