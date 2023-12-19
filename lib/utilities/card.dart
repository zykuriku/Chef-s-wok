import 'package:chefs_wok/screens/favorites.dart';
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
String desc = "";
List<String> steps = [];

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
      steps.add(data[0]['steps'][i]['step']);
    }

    Api summ = Api(
        'https://api.spoonacular.com/recipes/${id}/ingredientWidget.json?id=$id&apiKey=$apiKey');
    var sumData = await summ.getData();
    int ingLen = sumData['ingredients'].length();
    for (int i = 0; i < ingLen; i++) {
      print(sumData['ingredients'][i]['name']);
    }
    // print(desc);
    print(steps);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [gColor, nColor, kColor, bgColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(10.0),
                color: gColor),
            child: ListView(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      title,
                      style: tStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Image(
                      image: NetworkImage(imageUrl),
                    )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Ready in ',
                              style: subStyle,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            String selectedItemTitle = title;
                            int selectedItemID = id;
                            favListTitle.add(selectedItemTitle);
                            favListId.add(selectedItemID);
                          });
                        },
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   child: Text(desc),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                        itemCount: len,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            (index + 1).toString() + ". " + steps[index] + "\n",
                            style: TextStyle(),
                          );
                        }),
                  ),
                  Container(
                    color: Colors.brown,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextButton(
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FavoritesPage(
                                              favList: favListTitle,
                                            )))
                              },
                          child: Row(
                            children: [
                              Text(
                                'Go to ',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(Icons.favorite)
                            ],
                          )),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
