class Product {
  String name;
  int quantity;
  String description;

  Product(
      {required this.name, required this.quantity, required this.description});

  @override
  String toString() {
    return 'Product{name: $name, price: $quantity, description: $description}';
  }
}
