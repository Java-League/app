class Player {
  int id;
  String name;
  int overall;
  double price;
  String imageUrl;

  Player({
    required this.id,
    required this.name,
    required this.overall,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overall': overall,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    id: json["id"],
    name: json["name"],
    overall: json["overall"],
    price: json["price"],
    imageUrl: json["imageUrl"],
  );
}
