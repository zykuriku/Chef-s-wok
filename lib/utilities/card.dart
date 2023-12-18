import 'package:flutter/material.dart';
import 'package:chefs_wok/utilities/api.dart';
import 'constants.dart';

dynamic decodedData = "";
String imageUrl = "";
String title = "";
int id = 0;
int len = 0;
dynamic recipeData = "";
List<String> favListTitle = [];
List<int> favListId = [];

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
    print(id);
    getData(id);
  }

  void getData(int id) async {
    Api api = Api(
        'https://api.spoonacular.com/recipes/$id/analyzedInstructions?id=$id&apiKey=$apiKey');
    var data = await api.getData();

    len = data[0]['steps'].length;
    print(len);
    for (int i = 0; i < len; i++) {
      print(data[0]['steps'][i]['step']);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [gColor, nColor, kColor, bgColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(10.0),
              color: gColor),
          child: ListView(children: [
            Center(child: Text(title)),
            Center(child: Image(image: NetworkImage(imageUrl))),
            Row(
              children: [
                Text('Description'),
                IconButton(
                  onPressed: () {
                    setState(() {
                      String selectedItemTitle = title;
                      int selectedItemID = id;
                      favListTitle.add(selectedItemTitle);
                      favListId.add(selectedItemID);
                    });
                  },
                  icon: Icon(Icons.favorite),
                )
              ],
            ),
            ListView.builder(
                itemCount: len,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [],
                  );
                }),
          ]),
        ),
      ),
    );
  }
}
