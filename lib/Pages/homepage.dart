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
          "uniConnect Malawi",
          style: TextStyle(
              color: Colors.orange, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.green),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: _buildDrawer(),
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
              _buildShoeSection(), // Add Shoe Section here
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.green,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.orange),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.green, size: 30),
                ),
                SizedBox(height: 10),
                Text(
                  'Hello, User',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'user@example.com',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Shop'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.currency_exchange),
            title: const Text('Currency'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.contact_support_outlined),
            title: const Text('Help'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {},
          )
        ],
      ),
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
            color: Colors.orange,
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
                  child: Icon(categories[index]['icon'], color: Colors.orange),
                ),
                const SizedBox(height: 5),
                Text(
                  categories[index]['name'],
                  style: const TextStyle(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

Widget _buildShoeSection() {
  final List<Map<String, String>> shoeData = [
    {'image': 'assets/shoes/airforce.jpg', 'name': 'iphone 12 pro max', 'price': '850,000'},
    {'image': 'assets/shoes/timberland.jpg', 'name': 'Timberland', 'price': '150,000'},
    {'image': 'assets/shoes/converse.jpg', 'name': 'classic jersey', 'price': '30,0000'},
    {'image': 'assets/shoes/airmax.jpg', 'name': 'Air Max', 'price': '450,00'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10),
      const Text(
        "Latest Arrivals",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.65,
        ),
        itemCount: shoeData.length,
        itemBuilder: (context, index) {
          return ShoeCard(
            imageUrl: shoeData[index]['image']!,
            name: shoeData[index]['name']!,
            price: shoeData[index]['price']!,
           
          );
        },
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


class ShoeCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;

  const ShoeCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
  }) : super(key: key);

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choose an Action',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.green),
                title: const Text('Add to Cart'),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$name added to cart')),
                  );
                  // Add your add-to-cart logic here
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.payment, color: Colors.blue),
                title: const Text('more details'),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Proceeding to buy $name')),
                  );
                  // Add your buy-now logic here
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "\$mwk{price}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.greenAccent),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => _showOptions(context),
                  child: const Icon(Icons.add_circle, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
