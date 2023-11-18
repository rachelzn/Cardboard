import 'package:cardboard/screens/login.dart';
import 'package:cardboard/screens/product_list.dart';
import 'package:flutter/material.dart';
import 'package:cardboard/screens/menu.dart';
import 'package:cardboard/screens/boardlist_form.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CardboardCard extends StatelessWidget {
  final CardboardItem item;
  const CardboardCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: item.backgroundColor,
      child: InkWell(
        onTap: () async {
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
          } else if (item.name == "logout") {
            final response =
                await request.logout("http://127.0.0.1:8000/auth/logout/");
            String message = response["message"];
            if (response['status']) {
              String uname = response["username"];
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("$message Sampai jumpa, $uname."),
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("$message"),
                ),
              );
            }
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
