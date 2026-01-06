class EventService {
  final String id;
  final String name;
  final String icon; // Using standard icon names or path if needed, for simplicity we might use a category string
  final double price;
  final String unit; // e.g., 'per guest', 'per day'

  EventService({
    required this.id,
    required this.name,
    required this.icon,
    required this.price,
    required this.unit,
  });

  static List<EventService> get mockServices => [
    EventService(id: '1', name: 'Premium Catering', icon: 'restaurant', price: 1500, unit: 'per plate'),
    EventService(id: '2', name: 'Sound System', icon: 'speaker', price: 25000, unit: 'per day'),
    EventService(id: '3', name: 'Logistics & Transport', icon: 'directions_bus', price: 10000, unit: 'per vehicle'),
    EventService(id: '4', name: 'Photography', icon: 'camera_alt', price: 50000, unit: 'per day'),
    EventService(id: '5', name: 'Floral Decor', icon: 'local_florist', price: 75000, unit: 'per event'),
  ];
}
