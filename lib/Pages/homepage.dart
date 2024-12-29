import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MalawiSuperAppPage extends StatelessWidget {
  const MalawiSuperAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Malawi Super App",
          style: TextStyle(color: Colors.orange, fontSize: 22),
          
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.green),
            onPressed: () {},
          ),
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[200],
            child: IconButton(
              icon: const Icon(Icons.person, color: Colors.green),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildBannerSlider(),
              const SizedBox(height: 20),
              _buildCategoryList(),
              const SizedBox(height: 20),
           
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search...",
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.filter_list, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildBannerSlider() {
    final List<String> bannerImages = [
      'assets/banner1.jpg',
      'assets/banner2.jpg',
      'assets/banner3.jpg',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
      ),
      items: bannerImages.map((imagePath) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryList() {
    final List<Map<String, dynamic>> categories = [
      {'name': 'E-Commerce', 'icon': Icons.shopping_cart},
      {'name': 'Payments', 'icon': Icons.payment},
      {'name': 'Transport', 'icon': Icons.local_taxi},
      {'name': 'Bills', 'icon': Icons.receipt},
      {'name': 'Food', 'icon': Icons.fastfood},
      {'name': 'Banking', 'icon': Icons.account_balance},
      {'name': 'Social', 'icon': Icons.group},
      {'name': 'Education', 'icon': Icons.school},
      {'name': 'Health', 'icon': Icons.health_and_safety},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Icon(categories[index]['icon'], color: Colors.black),
                ),
                const SizedBox(height: 5),
                Text(categories[index]['name'],
                
                style: TextStyle(fontSize: 12),),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title, VoidCallback onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onViewAll,
          child: const Text("Learn More"),
        ),
      ],
    );
  }

 

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) {},
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: "Shop",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: "About",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_support),
          label: "Help",
        ),
      ],
    );
  }
}
