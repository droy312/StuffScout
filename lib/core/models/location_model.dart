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
}
