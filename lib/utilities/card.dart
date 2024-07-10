import 'package:chefs_wok/screens/favorites.dart';
import 'package:flutter/material.dart';
import 'package:chefs_wok/utilities/api.dart';
import 'constants.dart';

dynamic decodedData = "";
String imageUrl = "";
String title = "";
int id = 0;
int len = 0;
int time = 0;
Color iconColor = Colors.white;
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
    Api apii = Api(
        'https://api.spoonacular.com/recipes/${id}/information?id=$id&apiKey=$apiKey');
    var d = await apii.getData();
    time = d['readyInMinutes'];
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
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [gColor, nColor, kColor, bgColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),

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
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Image(
                                              image: NetworkImage(imageUrl),
                                            ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.brown,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              time.toString() + ' min',
                              style: subStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (iconColor == Colors.white) {
                              String selectedItemTitle = title;
                              int selectedItemID = id;
                              favListTitle.add(selectedItemTitle);
                              favListId.add(selectedItemID);
                              iconColor = Colors.red;
                            } else {
                              iconColor = Colors.white;
                            }
                          });
                        },
                        iconSize: 35.0,
                        icon: Icon(
                          Icons.favorite,
                          color: iconColor,
                        ),
                      ),
                    ),
                  ],
                ),
                // Container(
                //   child: Text(desc),
                // ),
                Expanded(child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),topRight: Radius.circular(50.0))
                        ,color: Colors.brown.shade900,
                  ),

                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Center(
                          child: Text(
                            'Recipe',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListView.builder(
                            itemCount: len,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Text(
                                (index + 1).toString() + ". " + steps[index] + "\n",
                                style: TextStyle(
                                  color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic),
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 60.0),
                        child: Container(
                          width: 100.0,
                          decoration: BoxDecoration(
                              color: Colors.brown.shade400,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextButton(
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FavoritesPage(
                                            favList: favListTitle,
                                          )))
                                },
                                child: Text(
                                  'Favorites',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ))

              ]),
        ),
      ),
    );
  }
}
