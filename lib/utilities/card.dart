import 'package:flutter/material.dart';
import 'package:chefs_wok/utilities/api.dart';
import 'constants.dart';

dynamic decodedData = "";
String imageUrl = "";
String title = "";
int id = 0;

class Cardd extends StatefulWidget {
  final data;
  Cardd({required this.data});

  @override
  State<Cardd> createState() => _CarddState();
}

class _CarddState extends State<Cardd> {
  @override
  void initState() {
    super.initState();
    decodedData = widget.data;
    imageUrl = decodedData['results'][0]['image'];
    title = decodedData['results'][0]['title'];
    id = decodedData['results'][0]['id'];
    // getData(id);
  }

  // void getData(int id) {
  //   Api api = Api(url);
  //   var data = api.getData();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Center(child: Text(title)),
        backgroundColor: Colors.brown,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Image(image: NetworkImage(imageUrl))],
        ),
      ),
    );
  }
}
