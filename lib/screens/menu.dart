import 'package:flutter/material.dart';
import 'package:cardboard/styles/colors.dart';
import 'package:cardboard/widgets/board_card.dart';
import 'package:cardboard/widgets/left_drawer.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final List<CardboardItem> items = [
    CardboardItem("My Product", Icons.checklist, Colorz.avogreen),
    CardboardItem("Add Product", Icons.add_shopping_cart, Colorz.pink),
    CardboardItem("Logout", Icons.logout, Colorz.skyblue),
  ];

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cardboard', 
        ),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'My Cardboard', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((CardboardItem item) {
                  // Iterasi untuk setiap item
                  return CardboardCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardboardItem {
  final String name;
  final IconData icon;
  final Color backgroundColor;

  CardboardItem(this.name, this.icon, this.backgroundColor);
}
