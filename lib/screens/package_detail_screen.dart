import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/package.dart';
import '../models/booking.dart';
import '../providers/booking_provider.dart';
import '../widgets/custom_button.dart';

class PackageDetailScreen extends StatelessWidget {
  const PackageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final package = ModalRoute.of(context)!.settings.arguments as EventPackage;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                   Image.asset(
                    package.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          package.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '₹${(package.price / 100000).toStringAsFixed(1)}L',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD4AF37),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Starting Price',
                    style: TextStyle(color: Colors.grey),
                  ),
                  
                  const Divider(height: 32),
                  
                  const Text(
                    'Package Inclusions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0C1C2C),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...package.inclusions.map((inclusion) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: Color(0xFFD4AF37), size: 20),
                        const SizedBox(width: 12),
                        Text(
                          inclusion,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  )).toList(),
                  
                  const SizedBox(height: 32),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0C1C2C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Experience luxury like never before with our curated package designed to make your special day absolutely perfect. We handle every detail so you can focus on making memories.',
                    style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
                  ),
                  
                  const SizedBox(height: 48),
                  CustomButton(
                    text: 'Book This Package',
                    onPressed: () {
                      final newBooking = Booking(
                        id: const Uuid().v4(),
                        userId: 'user1', // Mock user ID
                        eventName: package.title,
                        date: DateTime.now(),
                        totalCost: package.price,
                        status: 'Pending',
                        thumbnailUrl: package.imageUrl,
                      );

                      Provider.of<BookingProvider>(context, listen: false).addBooking(newBooking);

                       ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Booking Request Sent! View in History.'),
                          backgroundColor: Color(0xFFD4AF37),
                        ),
                      );
                      Navigator.pushNamed(context, '/history');
                    },
                  ),const SizedBox(height: 16),
                  CustomButton(
                    text: 'Customize Services',
                    isOutlined: true,
                    onPressed: () {
                      Navigator.pushNamed(context, '/service-booking');
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
