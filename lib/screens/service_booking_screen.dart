import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/service.dart';
import '../models/booking.dart';
import '../providers/booking_provider.dart';
import '../widgets/custom_button.dart';

class ServiceBookingScreen extends StatefulWidget {
  const ServiceBookingScreen({super.key});

  @override
  State<ServiceBookingScreen> createState() => _ServiceBookingScreenState();
}

class _ServiceBookingScreenState extends State<ServiceBookingScreen> {
  // Map of serviceId -> quantity (0 means not selected)
  final Map<String, int> _selectedServices = {};

  double get _totalCost {
    double total = 0;
    _selectedServices.forEach((id, qty) {
      if (qty > 0) {
        final service = EventService.mockServices.firstWhere((s) => s.id == id);
        total += service.price * qty;
      }
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Services')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: EventService.mockServices.length,
              itemBuilder: (context, index) {
                final service = EventService.mockServices[index];
                final quantity = _selectedServices[service.id] ?? 0;

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                         // Icon Box
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4AF37).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            // Simple mapping for icons
                            service.icon == 'restaurant' ? Icons.restaurant :
                            service.icon == 'speaker' ? Icons.speaker :
                            service.icon == 'directions_bus' ? Icons.directions_bus :
                            service.icon == 'camera_alt' ? Icons.camera_alt :
                            service.icon == 'local_florist' ? Icons.local_florist :
                            Icons.star,
                            color: const Color(0xFFD4AF37),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service.name,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '₹${service.price.toStringAsFixed(0)} / ${service.unit}',
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        // Quantity Controls
                        if (quantity == 0)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedServices[service.id] = 1;
                              });
                            },
                             style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD4AF37),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(60, 32),
                                padding: EdgeInsets.zero,
                             ),
                            child: const Text('Add'),
                          )
                        else
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                color: Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 0) _selectedServices[service.id] = quantity - 1;
                                  });
                                },
                              ),
                              Text(
                                '$quantity',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle),
                                color: const Color(0xFFD4AF37),
                                onPressed: () {
                                  setState(() {
                                    _selectedServices[service.id] = quantity + 1;
                                  });
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Total bar
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Estimated Cost:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF0C1C2C)),
                    ),
                    Text(
                      '₹${_totalCost.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD4AF37),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Confirm Booking',
                  onPressed: () {
                    if (_totalCost > 0) {
                      // Create a summary of selected services
                      final selectedNames = _selectedServices.entries
                          .where((e) => e.value > 0)
                          .map((e) {
                            final service = EventService.mockServices.firstWhere((s) => s.id == e.key);
                            return '${service.name} (x${e.value})';
                          }).join(', ');

                      final newBooking = Booking(
                        id: const Uuid().v4(),
                        userId: 'user1',
                        eventName: 'Service Bundle: $selectedNames',
                        date: DateTime.now(),
                        totalCost: _totalCost,
                        status: 'Pending',
                        thumbnailUrl: 'assets/images/welcome_bg.jpg', // Default image for services
                      );

                      Provider.of<BookingProvider>(context, listen: false).addBooking(newBooking);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Services Booked Successfully!')),
                      );
                      Navigator.pushReplacementNamed(context, '/history');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select at least one service.')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
