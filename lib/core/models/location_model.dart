class LocationModel {
  const LocationModel({
    required this.id,
    required this.house,
    this.room,
    this.containerListInOrder,
  });

  final String id;
  final String house;
  final String? room;
  final List<String>? containerListInOrder;

  /// Input: Location(id: '123', house: 'house123', room: 'room123',
  /// containerListInOrder: ['container1', 'container2', 'container3',])
  ///
  /// Output: house123 > room123 > container1 > container2 > container3
  String toLocationString() {
    String location = house;

    if (room != null) {
      location += ' > $room';
    }

    if (containerListInOrder != null) {
      for (final container in containerListInOrder!) {
        location += ' > $container';
      }
    }

    return location;
  }
}
