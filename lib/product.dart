class Product{
  String name;
  double price;
  int quantity;

  Product({required this.name,required this.price,required this.quantity});

  @override
  String toString() {
    return '$name, price: $price, quantity: $quantity';
  }
}