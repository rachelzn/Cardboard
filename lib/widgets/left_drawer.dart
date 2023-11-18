// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cardboard/screens/product_list.dart';
import 'package:cardboard/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:cardboard/screens/menu.dart';
import 'package:cardboard/screens/boardlist_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colorz.beigebg,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colorz.beigebg,
              ),
              child: Column(
                children: [
                  Text(
                    'Cardboard',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colorz.black,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text(
                    "Inventory made easy.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colorz.black,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home Page'),
              // Bagian redirection ke MyHomePage
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_box_outlined),
              title: const Text('Add Product'),
              // Bagian redirection ke ShopFormPage
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CardboardFormPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.dashboard_customize_outlined),
              title: const Text('My Cardboard'),
              onTap: () {
                // Route menu ke halaman produk
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
