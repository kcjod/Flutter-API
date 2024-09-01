class Welcome {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;

  Welcome({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    category: json["category"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
  };

  @override
  String toString() {
    return '{id: $id, title: $title, price: $price, description: $description, category: $category, image: $image}\n';
  }
}
