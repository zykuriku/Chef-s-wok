import 'package:flutter/material.dart';
import 'package:chefs_wok/utilities/card.dart';
import 'package:chefs_wok/utilities/constants.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gColor,
      appBar: AppBar(
        title: Text('My faves'),
        centerTitle: true,
      ),
    );
  }
}
