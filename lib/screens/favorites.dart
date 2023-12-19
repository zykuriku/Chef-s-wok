import 'package:flutter/material.dart';
import 'package:chefs_wok/utilities/card.dart';
import 'package:chefs_wok/utilities/constants.dart';
import 'package:chefs_wok/screens/homepage.dart';
import 'package:chefs_wok/utilities/api.dart';

class FavoritesPage extends StatefulWidget {
  final List<String> favList;

  const FavoritesPage({required this.favList, super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gColor,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('My faves'),
        centerTitle: true,
      ),
      body: widget.favList.isEmpty
          ? const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: gColor,
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.brown,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'No faves yet..',
                    style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              itemBuilder: (BuildContext context, int index) => ListTile(
                title: GestureDetector(
                    child: ListTile(
                      title: Text(favListTitle[index]),
                      leading: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () async {
                      String url =
                          'https://api.spoonacular.com/recipes/complexSearch?query=${favListTitle[index]}&number=1&apiKey=$apiKey';
                      Api a = Api(url);

                      var dd = await a.getData();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Cardd(data: dd)));
                    }),
              ),
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 2.0,
              ),
              itemCount: favListTitle.length,
            ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: kColor,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: kColor,
            ),
            label: 'Favorites')
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
