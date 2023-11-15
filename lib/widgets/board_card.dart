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
        // Area responsive terhadap sentuhan
        onTap: () async {
          if (item.name == "Add Product") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CardboardFormPage()),
            );
          } else if (item.name == "My Product") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductPage()),
            );
          } else if (item.name == "Logout") {
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
          }
        }, // This closing bracket was missing
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
