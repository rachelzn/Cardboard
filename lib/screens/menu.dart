import 'package:cardboard/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:cardboard/styles/colors.dart';
import 'package:cardboard/styles/fonts.dart';
import 'package:cardboard/widgets/board_card.dart';
import 'package:cardboard/widgets/left_drawer.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final List<CardboardItem> items = [
    CardboardItem(
        "my cardboard", Icons.dashboard, Colorz.darkgreen, Colorz.avogreen),
    CardboardItem("add item", Icons.add_box, Colorz.orange, Colorz.lightbeige),
    CardboardItem(
        "count stock", Icons.qr_code_scanner, Colorz.avogreen, Colorz.orange),
    CardboardItem("logout", Icons.logout, Colorz.darkgreen, Colorz.skyblue),
  ];

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        /*
        title: const Text(
          'Cardboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),*/
        backgroundColor: Colorz.darkgreen,
        foregroundColor: Colorz.pink,
      ),
      drawer: const LeftDrawer(),
      backgroundColor: Colorz.darkgreen,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 800,
                decoration: BoxDecoration(
                  color: Colorz.beigebg, // background of rectangle
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                ),
                margin: EdgeInsets.only(top: 120.0), // top margin
              ),
            ),
            Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    'Welcome, User!',
                    textAlign: TextAlign.left,
                    style: Fontz.B36,
                  ),
                ),
                SizedBox(height: 50),
                // search bar
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity, // full width
                    decoration: BoxDecoration(
                      color: Colorz.beigebg,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colorz.black.withOpacity(0.15),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      // controller: _searchController,
                      style: TextStyle(color: Colorz.black),
                      decoration: InputDecoration(
                        hintText: "search my cardboard...",
                        hintStyle: TextStyle(color: Colorz.ashbrown),
                        filled: true,
                        fillColor: Colorz.beigebg, // fill the textfield
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colorz.ashbrown,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: Colorz.black), // create black border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: Colorz.black), // black border when focused
                        ),
                      ),
                    ),
                  ),
                ),
                // Cards
                Container(
                  height: 200, // Adjust the height
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 200, // Adjust the width
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: CardboardCard(items[index]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 300, // height of bottom sheet
                decoration: BoxDecoration(
                  color: Colorz.beigebg, // background color of the bottom sheet
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                ),
                child: Center(
                  child: Text(
                    'Bottom Sheet Content',
                    style: Fontz.B15,
                  ),
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colorz.avogreen,
        ),
        backgroundColor: Colorz.darkgreen,
      ),
      //bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}

class CardboardItem {
  final String name;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  CardboardItem(this.name, this.icon, this.iconColor, this.backgroundColor);
}
