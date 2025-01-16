import 'package:flutter/material.dart';
import 'package:super_app/models/hostel_model.dart';
import 'package:super_app/services/hostel_service.dart';
import 'hostel_detail_page.dart';  // Import the detail page

class HostelPage extends StatefulWidget {
  @override
  _HostelPageState createState() => _HostelPageState();
}

class _HostelPageState extends State<HostelPage> {
  late Future<List<Hostel>> _hostels;

  @override
  void initState() {
    super.initState();
    _hostels = HostelService().fetchHostels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Booking'),
      ),
      body: FutureBuilder<List<Hostel>>(
        future: _hostels,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hostels found'));
          }

          final hostels = snapshot.data!;

          return Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              // Recommended Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommended Hostels',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(onPressed: () {}, child: Text('See all')),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hostels.length,
                  itemBuilder: (context, index) {
                    final hostel = hostels[index];
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.network(
                            hostel.image.isNotEmpty ? hostel.image : 'https://via.placeholder.com/150',
                            width: 150,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(hostel.houseName),
                          ),
                          Text('Price: MWK ${hostel.price} / month'),
                          TextButton(
                            onPressed: () {
                              // Navigate to hostel details page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HostelDetailPage(hostel: hostel),
                                ),
                              );
                            },
                            child: Text('See More'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Nearby Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nearby Hostels',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(onPressed: () {}, child: Text('See all')),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: hostels.length,
                  itemBuilder: (context, index) {
                    final hostel = hostels[index];
                    return ListTile(
                      leading: Image.network(
                        hostel.image.isNotEmpty ? hostel.image : 'https://via.placeholder.com/150',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(hostel.houseName),
                      subtitle: Text('${hostel.location} • MWK ${hostel.price} / month'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to details
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HostelDetailPage(hostel: hostel),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
