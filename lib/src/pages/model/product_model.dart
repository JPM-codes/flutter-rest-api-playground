class ProductModel {
  int id;
  String title;
  String description;
  double price;
  String? brand; 
  String thumbnail;
  List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.brand,
    required this.thumbnail,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      brand: json['brand'] ?? 'Sem Marca',
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
    );
  }
}