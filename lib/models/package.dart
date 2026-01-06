class EventPackage {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final List<String> inclusions;

  EventPackage({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.inclusions,
  });

  // Mock data
  static List<EventPackage> get mockPackages => [
        EventPackage(
          id: '1',
          title: 'Royal Wedding Package',
          imageUrl: 'assets/images/pkg_wedding.jpg',
          price: 500000,
          inclusions: ['Venue for 500 Guests', 'Premium Decor Theme', 'Professional DJ Setup', '3-Course Buffet Dinner', 'Bridal Suite'],
        ),
        EventPackage(
          id: '2',
          title: 'Corporate Tech Fest',
          imageUrl: 'assets/images/pkg_corporate.jpg',
          price: 350000,
          inclusions: ['Auditorium for 1000', 'Audio/Visual Setup', 'High-Speed WiFi', 'Catering (Coffee/Lunch)', 'Registration Desk'],
        ),
        EventPackage(
          id: '3',
          title: 'Concert Extravaganza',
          imageUrl: 'assets/images/pkg_concert.jpg',
          price: 1200000,
          inclusions: ['Stadium Venue', 'Stage Construction', 'concert Lighting & Sound', 'Security Team', 'Backstage Access'],
        ),
      ];
}
