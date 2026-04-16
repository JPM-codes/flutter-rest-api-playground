class RecipeModel {
  int id;
  String name;
  List<String> ingredients;
  List<String> instructions;
  int servings;
  int caloriesPerServing;
  String image;
  String difficulty;

 RecipeModel({
  required this.id,
  required this.name,
  required this.ingredients,
  required this.instructions,
  required this.servings,
  required this.caloriesPerServing,
  required this.image,
  required this.difficulty,
});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      name: json['name'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: List<String>.from(json['instructions']),
      servings: json['servings'],
      caloriesPerServing: json['caloriesPerServing'],
      image: json['image'],
      difficulty: json['difficulty'],
    );
  }
}