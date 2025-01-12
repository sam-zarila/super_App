import 'package:flutter/material.dart';

import 'homepage.dart';
import '../Pages/marketPlace.dart';
import '../services/cart_services.dart';
import '../Pages/cartpage.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int _selectedIndex = 0;

  // Create an instance of CartService
  final CartService cartService = CartService('http://127.0.0.1:3000/cart');

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      MalawiSuperAppPage(),
      MarketPage(cartService: cartService), 
      Cartpage(cartService: cartService),

      Placeholder(),
      Placeholder(),
      Placeholder(),
    ];
  }

  // Get the logged-in user's UID (user ID) from Firebase Authentication
 

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        items: [
          _buildBottomNavItem(Icons.home, 'Home', 0),
          _buildBottomNavItem(Icons.store, 'MarketPlace', 1),
          _buildBottomNavItem(Icons.shopping_cart, 'Cart', 2),
          _buildBottomNavItem(Icons.message, 'Message', 3),
          _buildBottomNavItem(Icons.person, 'Profile', 4),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.orange,
        selectedFontSize: 13,
        unselectedFontSize: 12,
        showSelectedLabels: true,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(
      IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;

    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInCubic,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.withOpacity(0.2) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.orange : Colors.grey[400],
          size: isSelected ? 28 : 24,
        ),
      ),
      label: label,
    );
  }
}
