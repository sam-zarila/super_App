import 'package:flutter/material.dart';
import '../models/marketplace.model.dart';
import '../services/marketplace.service.dart';

class LatestArrivals extends StatefulWidget {
  const LatestArrivals({super.key});

  @override
  State<LatestArrivals> createState() => _LatestArrivalsState();
}

class _LatestArrivalsState extends State<LatestArrivals> {
  final MarketplaceService _marketplaceService = MarketplaceService();
  late Future<List<LatestArrivals>> itemsFuture;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
