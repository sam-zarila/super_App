import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MalawiSuperAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Malawi Super App",
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.grey),
            onPressed: () {},
          ),
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[200],
            child: IconButton(
              icon: const Icon(Icons.person, color: Colors.grey),
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
              _buildSectionTitle("About the App", () {}),
              const SizedBox(height: 10),
              _buildContentSection(),
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
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Icon(categories[index]['icon'], color: Colors.black),
                ),
                const SizedBox(height: 5),
                Text(categories[index]['name']),
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

  Widget _buildContentSection() {
    final List<Map<String, String>> features = [
      {
        'title': "E-Commerce & Marketplace",
        'description':
            "A platform for users to shop for products ranging from groceries to electronics. Features local businesses, artisans, and farmers to promote 'Buy Malawi Build Malawi.'"
      },
      {
        'title': "Digital Payments",
        'description':
            "Integrated mobile money options (Airtel Money, Mpamba). Support for PayChangu or similar gateways for seamless in-app transactions."
      },
      {
        'title': "Transportation & Logistics",
        'description':
            "Ride-hailing services (boda bodas, taxis). Courier services for package delivery and logistics solutions."
      },
      {
        'title': "Bill Payments & Utilities",
        'description':
            "Utility bill payments for electricity, water, and airtime recharges. Options for school fees or rent payments."
      },
      {
        'title': "Food & Grocery Delivery",
        'description':
            "Partnerships with local restaurants and markets to enable food delivery. Grocery shopping with same-day delivery options."
      },
      {
        'title': "Banking & Financial Services",
        'description':
            "Integration with banks for mobile banking and micro-lending services. Savings and investment opportunities tailored to low-income groups."
      },
      {
        'title': "Social & Community Engagement",
        'description':
            "Forums for local events, news updates, and community discussions. Integration with social networks to connect users with common interests."
      },
      {
        'title': "Education & Skill Development",
        'description':
            "Online courses, tutorials, and resources for personal and professional development. Partnership with educational institutions for enrollment and e-learning."
      },
      {
        'title': "Health & Wellness",
        'description':
            "Telemedicine services for virtual doctor consultations. Pharmacy delivery services and health information resources."
      },
    ];

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feature['title']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    feature['description']!,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
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
