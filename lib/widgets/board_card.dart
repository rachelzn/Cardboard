import 'package:flutter/material.dart';
import 'package:cardboard/screens/menu.dart';
import 'package:cardboard/screens/boardlist_form.dart';

class CardboardCard extends StatelessWidget {
  final CardboardItem item;
  const CardboardCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.backgroundColor,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          if (item.name == "Add Product") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CardboardFormPage()),
            );
          } else {
            // Show SnackBar for other buttons
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  content: Text("You've pressed the '${item.name}' button!")));
          }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
