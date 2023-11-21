import 'package:cardboard/styles/colors.dart';
import 'package:cardboard/styles/fonts.dart';
import 'package:cardboard/widgets/bottom_bar.dart';
import 'package:cardboard/widgets/left_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cardboard/models/product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];

  Future<List<Product>> fetchProduct() async {
    var url = Uri.parse('http://127.0.0.1:8000/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Product> list_product = [];
    for (var d in data) {
      if (d != null) {
        list_product.add(Product.fromJson(d));
      }
    }
    return list_product;
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    String searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _filteredProducts
          .where((product) =>
              product.fields.name.toLowerCase().contains(searchTerm) ||
              product.fields.description.toLowerCase().contains(searchTerm))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colorz.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'My Cardboard',
          style: Fontz.B28,
        ),
        backgroundColor: Colorz.beigebg,
        foregroundColor: Colorz.black,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list_sharp),
            onPressed: () {
              // Implement the filter:
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AlphabetFilterScreen()));
            },
          ),
        ],
      ),
      drawer: const LeftDrawer(),
      backgroundColor: Colorz.beigebg,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colorz.beigebg,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colorz.black
                        .withOpacity(0.15), // shadow color and opacity
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 3), // Changes position of shadow
                  ),
                ],
              ), // full width
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colorz.black),
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colorz.ashbrown),
                  filled: true,
                  fillColor: Colorz.beigebg,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colorz.ashbrown,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colorz.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colorz.black),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchProduct(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Data doesn't exist.",
                          style: TextStyle(color: Colorz.black, fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  );
                } else {
                  _filteredProducts =
                      snapshot.data; // Initialize with all products
                  return ListView.builder(
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colorz.black),
                            borderRadius:
                                BorderRadius.circular(20), // Black border
                            color: Colorz.beigebg, // Beige background color
                          ),
                          child: Card(
                            color: Colorz
                                .beigebg, // Make the card transparent to show the container color
                            elevation: 0,
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                  color: Colorz
                                      .ashbrown, // Ashbrown square for the picture
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              title: Text(
                                product.fields.name,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    product.fields.description,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                "${product.fields.price}", // Display only the quantity number
                                style: TextStyle(
                                    fontSize: 15, color: Colorz.darkgreen),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
