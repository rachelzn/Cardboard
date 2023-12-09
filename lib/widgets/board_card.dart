import 'package:cardboard/screens/product_list.dart';
import 'package:flutter/material.dart';
import 'package:cardboard/screens/menu.dart';
import 'package:cardboard/screens/boardlist_form.dart';

class CardboardCard extends StatelessWidget {
  final CardboardItem item;
  const CardboardCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.backgroundColor,
      child: InkWell(
        onTap: () {
          if (item.name == "add item") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CardboardFormPage()),
            );
          } else if (item.name == "my cardboard") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductPage()),
            );
          } else {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(content: Text("You've pressed the ${item.name}!")));
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: item.iconColor,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: item.iconColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
