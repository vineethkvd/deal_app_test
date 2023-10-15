import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> cartItems = [
    Product(name: 'New Product', price: 9.99),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation:0,
      // ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(cartItems[index].name),
                        subtitle: Text(
                            "\$${cartItems[index].price.toStringAsFixed(2)}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Add item
                                setState(() {
                                  cartItems.add(Product(
                                      name: 'New Product', price: 9.99));
                                });
                              },
                              child: Icon(Icons.add),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Remove item
                                setState(() {
                                  cartItems.removeAt(index);
                                });
                              },
                              child: Icon(Icons.remove),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class Product {
  final String name;
  final double price;

  Product({
    required this.name,
    required this.price,
  });
}
