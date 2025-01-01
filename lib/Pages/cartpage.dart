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
        title: const Text('My Cart'),
      ),
      body: FutureBuilder<List<CartModel>>(
          future: widget.cartService.fetchCartItems(),
          builder: (context, snapshot) {
            if (!mounted) {
              return Container();
            }
          }),
    );
  }
}
