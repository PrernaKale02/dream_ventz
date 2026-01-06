class Booking {
  final String id;
  final String userId;
  final String eventName;
  final DateTime date;
  final double totalCost;
  final String status; // 'Confirmed', 'Pending', 'Completed'
  final String thumbnailUrl;

  Booking({
    required this.id,
    required this.userId,
    required this.eventName,
    required this.date,
    required this.totalCost,
    required this.status,
    required this.thumbnailUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'eventName': eventName,
      'date': date.toIso8601String(),
      'totalCost': totalCost,
      'status': status,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory Booking.fromMap(String id, Map<String, dynamic> map) {
    return Booking(
      id: id,
      userId: map['userId'] ?? '',
      eventName: map['eventName'] ?? 'Unknown Event',
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
      totalCost: (map['totalCost'] ?? 0).toDouble(),
      status: map['status'] ?? 'Pending',
      thumbnailUrl: map['thumbnailUrl'] ?? '',
    );
  }
}
