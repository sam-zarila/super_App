import '../models/cart_model.dart';
import '../services/cart_services.dart';
import 'package:flutter/material.dart';

class Cartpage extends StatefulWidget {
  final CartService cartService;

  const Cartpage({required this.cartService, Key? key}) : super(key: key);

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart 🛒'),
      ),
      body: FutureBuilder<List<CartModel>>(
          future: widget.cartService.fetchCartItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Your cart is empty'),
              );
            } else {
              final cartModels = snapshot.data!;
              double total = 0.0;

              for (var item in cartModels) {
                total += item.price * item.quantity;
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartModels.length,
                      itemBuilder: (context, index) {
                        final item = cartModels[index];
                        final itemTotal = item.price * item.quantity;

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                          child: ListTile(
                            leading: Image.network(
                              item.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(item.name),
                            subtitle: Text('Quantity: ${item.quantity}\nPrice: MWK${item.price}'),
                            trailing: Text('Total: MWK${itemTotal.toStringAsFixed(2)}'),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Total: MWK${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
