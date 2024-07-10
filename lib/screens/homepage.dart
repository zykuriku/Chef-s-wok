
import 'package:flutter/material.dart';
import 'favorites.dart';

import 'package:chefs_wok/utilities/api.dart';
import 'package:chefs_wok/utilities/card.dart';
import 'package:chefs_wok/utilities/constants.dart';

List<String> subtitle = [
  'Italiano',
  'Chilli Chinese',
  'Bueno Mexicano',
  'Desi Swaad',
  'Mochi Japanese'
];
List<IconData> icons = [
  Icons.fastfood,
  Icons.food_bank,
  Icons.emoji_food_beverage_outlined,
  Icons.restaurant,
  Icons.table_chart_outlined
];
List<List<String>> name = [
  ['Crostini', 'Risotto', 'Tiramisu', 'Lasagna'],
  ['Fried Rice', 'Steamed Flan', 'Spring Rolls', 'Almond Cookies'],
  [
    'Tacos',
    'Quesadilla',
    'Stuffed Potatoes',
    'Chicken Rice Bowl'
  ],
  ['Butter Chicken', 'Samosa', 'Mughlai Malai Kofta', 'Tandoori Chicken'],
  ['Sushi', 'Udon', 'Yakitori', 'Donburi']
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int id = 0;
  int _selectedIndex = 0;

  void callApi(String n) async {
    print(n);
    Api api = Api(
        'https://api.spoonacular.com/recipes/complexSearch?query=$n&number=1&apiKey=$apiKey');
    var data = await api.getData();
    print(data);
    if (data == null) {
      id = 0;
      return;
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Cardd(
                  data: data,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Let\'s cook, Jesse!',
        style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Colors.brown.shade900,
      ),
      bottomNavigationBar: bottomNavigationBar(),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [ kColor, bgColor, gColor, nColor,],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 50.0,
                        width: 250.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          color: Colors.brown.shade900
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(icons[index], color: Colors.white),
                            Padding(padding: const EdgeInsets.only(right: 5.0)),
                            Text(subtitle[index],
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white)),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 150.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, indexx) {
                            return Stack(children: [
                              Card(
                                color: Colors.brown.shade500,
                                elevation: 5.0,
                                child: Container(
                                  height: MediaQuery.of(context).size.width / 3,
                                  width: MediaQuery.of(context).size.width / 3,
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'images/$index$indexx.png',
                                            height: 85.0,
                                          ),
                                        ),
                                        Text(
                                          name[index][indexx],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        callApi(name[index][indexx]);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ]);
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color:  Colors.brown,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.brown,
            ),
            label: 'Favorites'),

      ],
      onTap: _onTap,
      selectedItemColor: kColor,
      currentIndex: _selectedIndex,
    );
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        break;

      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FavoritesPage(
                      favList: favListTitle,
                    )));
        break;

    }
  }
}
