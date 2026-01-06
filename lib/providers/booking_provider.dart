import 'package:flutter/material.dart';
import '../models/booking.dart';

class BookingProvider extends ChangeNotifier {
  final List<Booking> _bookings = [
    Booking(
      id: '101',
      userId: 'user1',
      eventName: 'Royal Wedding Package',
      date: DateTime.now().add(const Duration(days: 14)),
      totalCost: 500000,
      status: 'Confirmed',
      thumbnailUrl: 'assets/images/pkg_wedding.jpg',
    ),
    Booking(
      id: '102',
      userId: 'user1',
      eventName: 'Corporate Tech Fest',
      date: DateTime.now().subtract(const Duration(days: 30)),
      totalCost: 350000,
      status: 'Completed',
      thumbnailUrl: 'assets/images/pkg_corporate.jpg',
    ),
    Booking(
      id: '103',
      userId: 'user1',
      eventName: 'Custom Service Booking',
      date: DateTime.now().add(const Duration(days: 2)),
      totalCost: 25000,
      status: 'Pending',
      thumbnailUrl: 'assets/images/welcome_bg.jpg',
    ),
  ];

  List<Booking> get bookings => _bookings;

  void addBooking(Booking booking) {
    _bookings.insert(0, booking);
    notifyListeners();
  }
}
