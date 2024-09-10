class Restaurant {
  final String restaurantNameChi;
  final String restaurantNameEng;
  final String restaurantLink;
  final String notes;
  final List hashTag;
  final String imageLink;

  const Restaurant({
    required this.restaurantNameChi,
    required this.restaurantNameEng,
    required this.restaurantLink,
    required this.notes,
    required this.hashTag,
    required this.imageLink,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    Map fields = json['fields'];
    return Restaurant(
      restaurantNameChi: fields['restaurant_name_chi'],
      restaurantNameEng: fields['restaurant_name_eng'],
      restaurantLink: fields['restaurant_link'],
      notes: fields['notes'],
      hashTag: List<String>.from(fields['hashTag']),
      imageLink: fields['imageLink'],
    );
  }
}
