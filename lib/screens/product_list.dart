import 'package:flutter/material.dart';
import 'package:cardboard/models/product.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> products;

  ProductListPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        backgroundColor: Color(0xFFF8B3CA),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: ListTile(
              title: Text(product.name),
              subtitle: Text(
                  'Quantity: ${product.quantity}\nDescription: ${product.description}'),
            ),
          );
        },
      ),
    );
  }
}
