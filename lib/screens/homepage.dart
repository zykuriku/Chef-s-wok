import 'package:flutter/material.dart';
import 'favorites.dart';
import 'package:chefs_wok/utilities/api.dart';
import 'package:chefs_wok/utilities/card.dart';

List<String> subtitle = [
  'Italiano',
  'Chilli Chinese',
  'Bueno Mexicano',
  'Desi Swaad',
  'Moshi Moshi Japanese'
];

List<List<String>> name = [
  ['Carbonara', 'Risotto', 'Polenta', 'Pizza'],
  ['Mapo Tofu', 'Wonton Soup', 'Spring Rolls', 'Chinese Hot Pot'],
  ['Tacos', 'Quesadilla', 'Tamales', 'Chilaquiles'],
  ['Butter Chicken', 'Samosa', 'Vindaloo', 'Soya Chaap'],
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
    Api api = Api('https://api.spoonacular.com/recipes/complexSearch?query=$n');
    var data = await api.getData();
    if (data == null) {
      id = 0;
      return;
    }
    id = data['results'][0]['id'];
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Cardd(id: id)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Let\'s cook, Jesse!'),
      ),
      bottomNavigationBar: bottomNavigationBar(),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          SizedBox(height: 20.0),
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
                      color: Colors.orangeAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.emoji_food_beverage, color: Colors.white),
                          Padding(padding: const EdgeInsets.only(right: 5.0)),
                          Text(subtitle[index],
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                        ],
                      ),
                    ),
                    Container(
                      height: 150.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, indexx) {
                          return Stack(children: [
                            Card(
                              elevation: 5.0,
                              child: Container(
                                height: MediaQuery.of(context).size.width / 3,
                                width: MediaQuery.of(context).size.width / 3,
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  child: Text(name[index][indexx]),
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
                    SizedBox(height: 20.0),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites')
      ],
      onTap: _onTap,
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
            context, MaterialPageRoute(builder: (context) => FavoritesPage()));
        break;
    }
  }
}
