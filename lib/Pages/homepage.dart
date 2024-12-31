import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:super_app/Pages/Edu.dart';
import 'package:super_app/Pages/Health.dart';
import 'package:super_app/Pages/MobileMoney.dart';
import 'package:super_app/Pages/Taxi.dart';
import 'package:super_app/Pages/ToRefund.dart';
import 'package:super_app/Pages/Topay.dart';
import 'package:super_app/Pages/Toreceive.dart';
import 'package:super_app/Pages/Toship.dart';
import 'package:super_app/Pages/accomodation.dart';
import 'package:super_app/Pages/address.dart';
import 'package:super_app/Pages/food.dart';
import 'package:super_app/Pages/latestArrival.dart';
import 'package:super_app/Pages/random.dart';
import 'package:super_app/Pages/social.dart';
import 'package:super_app/Pages/utility.dart';

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
      drawer: _buildDrawer(context),
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
             const Center(

              child:  Text(
                'Discover Our Services',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green
                ),
                
              ),
             ),
             const SizedBox(height: 20),
              _buildCategoryList(context),
              const SizedBox(height: 20),
              _buildShoeSection(), 
               ElevatedButton(onPressed: (){},
                child: const Text(
                  'View More',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange
                  ),
                ))
      
      
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildDrawer(BuildContext context) {
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
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.payment, color: Colors.white),
            title: const Text('To Pay', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ToPayPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_shipping, color: Colors.white),
            title: const Text('To Ship', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ToShipPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.move_to_inbox, color: Colors.white),
            title:
                const Text('To Receive', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ToReceivePage()),
              );
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.replay_circle_filled, color: Colors.white),
            title: const Text('Refund', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ToRefundPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on, color: Colors.white),
            title:
                const Text('My Address', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddressPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title:
                const Text('Settings', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
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
    final List<Map<String, String>> bannerImages = [
      {
        'image': 'assets/happy.jpg',
        'text': 'Seamlessly Shopping',
      },
      {
        'image': 'assets/uber-cabs-1024x576.webp',
        'text': 'Find Taxi/Uber Here',
      },
      {
        'image': 'assets/Queens-Tavern-Steak.jpg',
        'text': 'Order Food Here',
      },
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
      ),
      items: bannerImages.map((banner) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                banner['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  banner['text']!,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryList(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'name': 'Accomodation', 'icon': Icons.hotel_sharp},
      {'name': 'Taxi/Uber', 'icon': Icons.local_taxi},
      {'name': 'Utility', 'icon': Icons.handshake},
      {'name': 'Food', 'icon': Icons.fastfood},
      {'name': 'Mobile Money', 'icon': Icons.mobile_friendly},
      {'name': 'Social', 'icon': Icons.group},
      {'name': 'Education', 'icon': Icons.school},
      {'name': 'Health', 'icon': Icons.health_and_safety},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            String categoryName = categories[index]['name'];
            if (categoryName == 'Accomodation') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccomodationPage()),
              );
            } else if (categoryName == 'Taxi/Uber') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TaxiPage()),
              );
            } else if (categoryName == 'Utility') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UtilityPage()),
              );
            } else if (categoryName == 'Food') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FoodPage()),
              );
            } else if (categoryName == 'Mobile Money') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MobilemoneyPage()),
              );
            } else if (categoryName == 'Social') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SocialPage()),
              );
            } else if (categoryName == 'Education') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EducationPage()),
              );
            } else if (categoryName == 'Health') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HealthPage()),
              );
            }
          },
          child: Column(
            children: [
              
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.orange,
                child: Icon(
                  categories[index]['icon'],
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  size: 30,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                categories[index]['name'],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }

Widget _buildShoeSection() {
  final List<Map<String, String>> shoeData = [
    {'image': 'assets/shoes/airforce.jpg', 'name': 'iphones', 'price': '850,000'},
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
                      "\mwk ${price}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.green),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => _showOptions(context),
                  child: const Icon(Icons.add_circle, color: Colors.redAccent),
                ),
              ],
            ),
          ),
         
        ],
      ),
      
    );
    
  }
}
