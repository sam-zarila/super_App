import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_app/Pages/ToRefund.dart';
import 'package:super_app/Pages/Topay.dart';
import 'package:super_app/Pages/Toreceive.dart';
import 'package:super_app/Pages/Toship.dart';
import 'package:super_app/Pages/address.dart';
import 'package:super_app/models/marketplace.model.dart';
import 'package:super_app/services/marketplace.service.dart';
import 'package:super_app/signup/Login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final MarketplaceService marketplaceService = MarketplaceService();
  String fullName = "Loading...";
  String email = "Loading...";

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        setState(() {
          fullName = userDoc['fullName'] ?? 'Guest User';
          email = userDoc['email'] ?? 'No Email';
        });
      } else {
        setState(() {
          fullName = 'Guest User';
          email = 'No Email';
        });
      }
    }
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.green,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.orange),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.green, size: 30),
                ),
                const SizedBox(height: 10),
                Text(
                  fullName,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  email,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.payment, color: Colors.white),
            title: const Text('To Pay', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ToPayPage())),
          ),
          ListTile(
            leading: const Icon(Icons.local_shipping, color: Colors.white),
            title: const Text('To Ship', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ToShipPage())),
          ),
          ListTile(
            leading: const Icon(Icons.move_to_inbox, color: Colors.white),
            title: const Text('To Receive', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ToReceivePage())),
          ),
          ListTile(
            leading: const Icon(Icons.replay_circle_filled, color: Colors.white),
            title: const Text('Refund', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ToRefundPage())),
          ),
          ListTile(
            leading: const Icon(Icons.location_on, color: Colors.white),
            title: const Text('My Address', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressPage())),
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title: const Text('Settings', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
                const Text(
                  'Open shop',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Latest Arrivals',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<MarketPlaceModel>>(
              future: marketplaceService.fetchLatestArrivals(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Failed to load latest arrivals"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No latest arrivals available"));
                } else {
                  final items = snapshot.data!;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _buildListingCard(item);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListingCard(MarketPlaceModel item) {
    return Card(
      elevation: 3,
      child: Column(
        children: [
          //Image.network(item.imageUrl, height: 100, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
           // child: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
